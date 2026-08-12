# Numbered matching files from the latest grip/grp search are available as
# $f1, $f2, ... and through `f COMMAND INDEX`.
declare -ag GRIP_FILES=()
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
    GRIP_FIRST_LINES=()
    GRIP_RESULT_COUNT=0
}

_grip_index_results() {
    local ignore_case=$1
    shift

    local -a rg_args=(-PHnM 1000 -g '!node_modules' -g '!puppeteer')
    local -A file_indexes=()
    local path line index

    if ((ignore_case)); then
        rg_args=(-i "${rg_args[@]}")
    fi

    while IFS= read -r -d '' path && IFS= read -r -d '' line; do
        if [[ -z ${file_indexes["$path"]+set} ]]; then
            index=${#GRIP_FILES[@]}
            file_indexes["$path"]=$index
            GRIP_FILES[index]=$path
            GRIP_FIRST_LINES[index]=$line
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
}

_grip_annotate_output() {
    local -a indexed_files=("${GRIP_FILES[@]}")
    local -a indexed_first_lines=("${GRIP_FIRST_LINES[@]}")
    local -A emitted_files=()
    local line plain_line path variable_name i

    _grip_clear_results

    while IFS= read -r line || [[ -n $line ]]; do
        plain_line=$line
        while [[ $plain_line =~ $'\e'\[[0-9\;]*m ]]; do
            plain_line=${plain_line/"${BASH_REMATCH[0]}"/}
        done

        for ((i = 0; i < ${#indexed_files[@]}; i++)); do
            path=${indexed_files[i]}
            if [[ $plain_line == "$path" && -z ${emitted_files["$path"]+set} ]]; then
                emitted_files["$path"]=1
                GRIP_FILES+=("$path")
                GRIP_FIRST_LINES+=("${indexed_first_lines[i]}")
                GRIP_RESULT_COUNT=${#GRIP_FILES[@]}
                variable_name="f$GRIP_RESULT_COUNT"
                printf -v "$variable_name" '%s' "$path"
                printf '%s [%d]\n' "$line" "$GRIP_RESULT_COUNT"
                continue 2
            fi
        done

        printf '%s\n' "$line"
    done
}

_grip_run() {
    local ignore_case=$1
    local force_file_list=$2
    shift 2

    local -a rg_args=(-PHnM 1000 -g '!node_modules' -g '!puppeteer')
    local output_file search_status

    if ((ignore_case)); then
        rg_args=(-i "${rg_args[@]}")
    fi

    _grip_clear_results
    _grip_index_results "$ignore_case" "$@"

    if [[ -t 1 ]]; then
        rg_args=(--color=always "${rg_args[@]}")
    fi

    output_file=$(mktemp "${TMPDIR:-/tmp}/grip-output.XXXXXX") || {
        printf 'grip: could not create output buffer\n' >&2
        return 1
    }

    command rg --heading "${rg_args[@]}" "$@" >"$output_file"
    search_status=$?
    _grip_annotate_output <"$output_file"
    rm -f -- "$output_file"

    return "$search_status"
}

grip() {
    local force_file_list=0
    local arg
    local -a provided_args=()
    local -a search_args=()

    for arg in "$@"; do
        if [[ $arg == --grip-list ]]; then
            force_file_list=1
        else
            provided_args+=("$arg")
        fi
    done

    _grip_resolve_search search_args "${provided_args[@]}" || return
    _grip_run 1 "$force_file_list" "${search_args[@]}"
}

grp() {
    local force_file_list=0
    local arg
    local -a provided_args=()
    local -a search_args=()

    for arg in "$@"; do
        if [[ $arg == --grip-list ]]; then
            force_file_list=1
        else
            provided_args+=("$arg")
        fi
    done

    _grip_resolve_search search_args "${provided_args[@]}" || return
    _grip_run 0 "$force_file_list" "${search_args[@]}"
}

f() {
    if (($# == 0)); then
        if ((GRIP_RESULT_COUNT == 0)); then
            printf 'f: no files matched the last grip/grp search\n' >&2
            return 1
        fi

        local i
        for ((i = 0; i < GRIP_RESULT_COUNT; i++)); do
            printf '%s [%d]\n' "${GRIP_FILES[i]}" "$((i + 1))"
        done
        return 0
    fi

    local index=${!#}
    local command_arg_count=$(($# - 1))
    local -a invocation=("${@:1:command_arg_count}")

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
    local command_name=${invocation[0]##*/}
    local command_text
    local GRIP_F_VIM_SEARCH

    if [[ -z $command_name ]]; then
        local cmd
        for cmd in neovim nvim vim vi v; do
            if command -v "$cmd" >/dev/null 2>&1; then
                command_name=$cmd
                invocation=("$cmd")
                break
            fi
        done
    fi

    case "$command_name" in
        v | vi | vim | nvim | neovim)
            invocation+=("+${GRIP_FIRST_LINES[array_index]}")
            if IFS= read -r -d '' GRIP_F_VIM_SEARCH <"$GRIP_SEARCH_STATE_FILE"; then
                export GRIP_F_VIM_SEARCH
                invocation+=(
                    -c
                    "let @/ = '\\V' . escape(\$GRIP_F_VIM_SEARCH, '\\') | call histadd('search', @/)"
                )
            fi
            ;;
    esac

    invocation+=(-- "$path")
    printf -v command_text '%q ' "${invocation[@]}"
    eval "$command_text"
}
