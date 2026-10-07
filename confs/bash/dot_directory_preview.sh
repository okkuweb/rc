# Preview the target of dot-based parent-directory aliases while typing.
_dot_directory_preview() {
    READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}.${READLINE_LINE:READLINE_POINT}"
    ((READLINE_POINT++))

    if [[ $READLINE_LINE =~ ^[.]{2,}$ ]]; then
        local levels=$((${#READLINE_LINE} - 1))
        local target=$PWD

        while ((levels-- > 0)); do
            target=${target%/*}
            [[ -n $target ]] || target=/
        done

        printf '\r\033[2K→ %s\n' "$target"
    fi
}

if [[ $- == *i* ]]; then
    bind -x '".":_dot_directory_preview'
fi
