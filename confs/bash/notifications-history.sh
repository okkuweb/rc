#!/bin/sh

command_name=${0##*/}
mode=new

case "$command_name" in
    notification-history-all)
        mode=all
        ;;
esac

case ${1-} in
    --all)
        mode=all
        ;;
    --count)
        mode=count
        ;;
    '')
        ;;
    *)
        printf 'Usage: %s [--all | --count]\n' "$command_name" >&2
        exit 2
        ;;
esac

dependencies='dunstctl jq'
if [ "$mode" != count ]; then
    dependencies="$dependencies less"
fi

for dependency in $dependencies; do
    if ! command -v "$dependency" >/dev/null 2>&1; then
        printf '%s: %s is required\n' "$command_name" "$dependency" >&2
        printf '\nPress Enter to close.' >&2
        read -r _
        exit 127
    fi
done

if ! history=$(dunstctl history); then
    printf '%s: could not read Dunst history\n' "$command_name" >&2
    exit 1
fi

if ! latest_timestamp=$(printf '%s\n' "$history" |
    jq -r '[.data[0][]?.timestamp.data | numbers] | max // 0')
then
    printf '%s: Dunst returned invalid history data\n' "$command_name" >&2
    exit 1
fi

since_timestamp=0
state_dir=${XDG_STATE_HOME:-"$HOME/.local/state"}/notification-history
state_file=$state_dir/last-open
boot_id=unknown
if [ -r /proc/sys/kernel/random/boot_id ]; then
    IFS= read -r boot_id </proc/sys/kernel/random/boot_id
fi

if [ "$mode" != all ]; then
    if [ -r "$state_file" ]; then
        IFS=' ' read -r saved_boot_id saved_timestamp <"$state_file"
        case $saved_timestamp in
            ''|*[!0-9]*) saved_timestamp=0 ;;
        esac
        if [ "$saved_boot_id" = "$boot_id" ]; then
            since_timestamp=$saved_timestamp
        fi
    fi
fi

if [ "$mode" = count ]; then
    printf '%s\n' "$history" |
        jq -r --argjson since "$since_timestamp" \
        '[.data[0][] |
            select((.timestamp.data? | numbers) > $since)] | length'
    exit
fi

if [ "$mode" = new ]; then
    if ! mkdir -p "$state_dir"; then
        printf '%s: could not create state directory: %s\n' \
            "$command_name" "$state_dir" >&2
        exit 1
    fi
    umask 077
    if ! printf '%s %s\n' "$boot_id" "$latest_timestamp" >"$state_file"; then
        printf '%s: could not save last-open state: %s\n' \
            "$command_name" "$state_file" >&2
        exit 1
    fi
fi

show_all=false
if [ "$mode" = all ]; then
    show_all=true
fi

printf '%s\n' "$history" |
    jq -r --argjson show_all "$show_all" \
    --argjson since "$since_timestamp" \
    '
        def sender:
            (.appname.data // "") as $name |
            if ($name | length) > 0 then $name else "Unknown" end;
        def title:
            (.summary.data // "") as $summary |
            if ($summary | length) > 0 then $summary else "(no title)" end;

        ([.data[0][] |
            select($show_all or ((.timestamp.data? | numbers) > $since))]
        ) as $notifications |
        "\u001b[1;33mSummary (\($notifications | length) notifications)\u001b[0m",
        (
            $notifications
            | group_by(sender)[]
            | "\u001b[1;36m\(.[0] | sender)\u001b[0m (\(length))",
              (. | group_by(title)[] | "  \u001b[1m\(.[0] | title)\u001b[0m (\(length))")
        ),
        "\n\u001b[2m════════════════════════════════════════════════════════════\u001b[0m\n",
        ($notifications[] |
            "\u001b[1;36m\(.appname.data // "Unknown")\u001b[0m — \u001b[1m\(.summary.data // "")\u001b[0m\n\(.body.data // "")\n\n\u001b[2m────────────────────────────────────────────────────────────\u001b[0m\n"
        )' |
    less -R
