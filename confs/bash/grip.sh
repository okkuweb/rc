# Numbered matching files from the latest grip/grp search are available as
# $f1, $f2, ... and through `f INDEX COMMAND`.
declare -ag GRIP_FILES=()
declare -ag GRIP_MATCH_COUNTS=()
declare -ag GRIP_FIRST_LINES=()
GRIP_RESULT_COUNT=0
GRIP_SEARCH_STATE_FILE=${GRIP_SEARCH_STATE_FILE:-"$HOME/.grip_last_search"}

_grip_save_search() {
    local temp_file

    temp_file=$(mktemp "${GRIP_SEARCH_STATE_FILE}.XXXXXX") || {
        printf 'grip: could not create search state file\n' >&2
        return 1
    }

    chmod 600 "$temp_file"
    if ! printf '%s\0' "$@" >"$temp_file"; then
        rm -f -- "$temp_file"
        printf 'grip: could not save previous search\n' >&2
        return 1
    fi

    if ! mv -f -- "$temp_file" "$GRIP_SEARCH_STATE_FILE"; then
        rm -f -- "$temp_file"
        printf 'grip: could not save previous search\n' >&2
        return 1
    fi
}

_grip_resolve_search() {
    local -n resolved_args=$1
    shift

    if (($# > 0)); then
        resolved_args=("$@")
        _grip_save_search "${resolved_args[@]}" || :
        return 0
    fi

    if [[ ! -s $GRIP_SEARCH_STATE_FILE ]]; then
        printf 'grip: no previous search\n' >&2
        return 2
    fi

    mapfile -d '' -t resolved_args <"$GRIP_SEARCH_STATE_FILE"
    if ((${#resolved_args[@]} == 0)); then
        printf 'grip: no previous search\n' >&2
        return 2
    fi
}

_grip_clear_results() {
    local i

    for ((i = 1; i <= GRIP_RESULT_COUNT; i++)); do
        unset "f$i"
    done

    GRIP_FILES=()
    GRIP_MATCH_COUNTS=()
    GRIP_FIRST_LINES=()
    GRIP_RESULT_COUNT=0
}

_grip_index_results() {
    local ignore_case=$1
    shift

    local -a rg_args=(-PHnM 1000 -g '!node_modules' -g '!puppeteer')
    local -A file_indexes=()
    local path line index i variable_name match_word

    if ((ignore_case)); then
        rg_args=(-i "${rg_args[@]}")
    fi

    while IFS= read -r -d '' path && IFS= read -r -d '' line; do
        if [[ -z ${file_indexes["$path"]+set} ]]; then
            index=${#GRIP_FILES[@]}
            file_indexes["$path"]=$index
            GRIP_FILES[index]=$path
            GRIP_MATCH_COUNTS[index]=1
            GRIP_FIRST_LINES[index]=$line
        else
            index=${file_indexes["$path"]}
            ((GRIP_MATCH_COUNTS[index]++))
        fi
    done < <(
        command rg "${rg_args[@]}" --json --color=never "$@" 2>/dev/null |
            command jq -j '
                select(.type == "match")
                | (.data.path.text // (.data.path.bytes | @base64d)), "\u0000",
                  (.data.line_number | tostring), "\u0000"
            ' 2>/dev/null
    )

    GRIP_RESULT_COUNT=${#GRIP_FILES[@]}
    ((GRIP_RESULT_COUNT > 0)) || return 0

    printf '\nMatching files:\n'
    for ((i = 0; i < GRIP_RESULT_COUNT; i++)); do
        variable_name="f$((i + 1))"
        printf -v "$variable_name" '%s' "${GRIP_FILES[i]}"

        match_word=matches
        ((GRIP_MATCH_COUNTS[i] == 1)) && match_word=match
        printf '[%d] %s — %d %s, first line %d\n' \
            "$((i + 1))" \
            "${GRIP_FILES[i]}" \
            "${GRIP_MATCH_COUNTS[i]}" \
            "$match_word" \
            "${GRIP_FIRST_LINES[i]}"
    done
}

_grip_run() {
    local ignore_case=$1
    shift

    local -a rg_args=(-PHnM 1000 -g '!node_modules' -g '!puppeteer')
    local search_status

    if ((ignore_case)); then
        rg_args=(-i "${rg_args[@]}")
    fi

    command rg "${rg_args[@]}" "$@"
    search_status=$?
    _grip_clear_results

    if ((search_status == 0)); then
        _grip_index_results "$ignore_case" "$@"
    fi

    return "$search_status"
}

grip() {
    local -a search_args=()

    _grip_resolve_search search_args "$@" || return
    _grip_run 1 "${search_args[@]}"
}

grp() {
    local -a search_args=()

    _grip_resolve_search search_args "$@" || return
    _grip_run 0 "${search_args[@]}"
}

f() {
    if (($# == 0)); then
        printf 'usage: f INDEX [COMMAND [ARG ...]]\n' >&2
        return 2
    fi

    local index=$1
    shift

    if [[ ! $index =~ ^[1-9][0-9]*$ ]]; then
        printf 'f: index must be a positive integer: %s\n' "$index" >&2
        return 2
    fi

    if ((index > GRIP_RESULT_COUNT)); then
        printf 'f: no saved file at index %d\n' "$index" >&2
        return 1
    fi

    local array_index=$((index - 1))
    local path=${GRIP_FILES[array_index]}

    if (($# == 0)); then
        printf '%s\n' "$path"
        return 0
    fi

    local command_name=${1##*/}
    local -a invocation=("$@")
    local command_text

    case "$command_name" in
        v | vi | vim | nvim | neovim)
            invocation+=("+${GRIP_FIRST_LINES[array_index]}")
            ;;
    esac

    invocation+=(-- "$path")
    printf -v command_text '%q ' "${invocation[@]}"
    eval "$command_text"
}
