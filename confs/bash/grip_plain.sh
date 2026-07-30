# Plain grip/grp fallback used when indexed results are unavailable.
GRIP_SEARCH_STATE_FILE=${GRIP_SEARCH_STATE_FILE:-"$HOME/.grip_last_search"}

_grip_plain_save_search() {
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

_grip_plain_resolve_search() {
    local -n resolved_args=$1
    shift

    if (($# > 0)); then
        resolved_args=("$@")
        _grip_plain_save_search "${resolved_args[@]}" || :
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

_grip_plain_run() {
    local ignore_case=$1
    shift

    local search_status

    if command -v rg &>/dev/null; then
        local -a rg_args=(-PHnM 1000 -g '!node_modules' -g '!puppeteer')
        ((ignore_case)) && rg_args=(-i "${rg_args[@]}")
        command rg "${rg_args[@]}" "$@"
    else
        local -a grep_args=(--color=auto -rPHn)
        ((ignore_case)) && grep_args=(-i "${grep_args[@]}")
        command grep "${grep_args[@]}" "$@"
    fi
    search_status=$?

    if ! command -v jq &>/dev/null; then
        printf '%s\n' 'warning: jq is not installed; numbered file results were not generated' >&2
    fi

    return "$search_status"
}

grip() {
    local arg
    local -a provided_args=()
    local -a search_args=()

    for arg in "$@"; do
        [[ $arg == --grip-list ]] || provided_args+=("$arg")
    done

    _grip_plain_resolve_search search_args "${provided_args[@]}" || return
    _grip_plain_run 1 "${search_args[@]}"
}

grp() {
    local arg
    local -a provided_args=()
    local -a search_args=()

    for arg in "$@"; do
        [[ $arg == --grip-list ]] || provided_args+=("$arg")
    done

    _grip_plain_resolve_search search_args "${provided_args[@]}" || return
    _grip_plain_run 0 "${search_args[@]}"
}
