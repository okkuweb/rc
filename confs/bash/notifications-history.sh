#!/bin/sh

for dependency in dunstctl jq less; do
    if ! command -v "$dependency" >/dev/null 2>&1; then
        printf 'notifications-history: %s is required\n' "$dependency" >&2
        printf '\nPress Enter to close.' >&2
        read -r _
        exit 127
    fi
done

dunstctl history |
    jq -r '.data[0][] |
        "\u001b[1;36m\(.appname.data // "Unknown")\u001b[0m — \u001b[1m\(.summary.data // "")\u001b[0m\n\(.body.data // "")\n\n\u001b[2m────────────────────────────────────────────────────────────\u001b[0m\n"' |
    less -R
