#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s <application-desktop-id>\n' "${0##*/}" >&2
  printf 'Example: %s org.nomacs.ImageLounge.desktop\n' "${0##*/}" >&2
}

if [[ $# -ne 1 ]]; then
  usage
  exit 2
fi

if ! command -v xdg-mime >/dev/null 2>&1; then
  printf 'Error: xdg-mime is required but was not found.\n' >&2
  exit 1
fi

desktop_id=$1
if [[ $desktop_id != *.desktop ]]; then
  desktop_id+='.desktop'
fi

mime_types=()
for mime_list in "${XDG_DATA_HOME:-$HOME/.local/share}/mime/types" /usr/local/share/mime/types /usr/share/mime/types; do
  if [[ -r $mime_list ]]; then
    while IFS= read -r mime; do
      [[ $mime == image/* ]] && mime_types+=("$mime")
    done < "$mime_list"
  fi
done

if [[ ${#mime_types[@]} -eq 0 ]]; then
  printf 'Error: no image MIME types found in the system MIME database.\n' >&2
  exit 1
fi

# Remove duplicates while retaining the MIME database order.
declare -A seen=()
count=0
for mime in "${mime_types[@]}"; do
  [[ ${seen[$mime]+yes} ]] && continue
  seen[$mime]=1
  xdg-mime default "$desktop_id" "$mime"
  ((count += 1))
done

printf 'Set %s as the default for %d image MIME types.\n' "$desktop_id" "$count"
