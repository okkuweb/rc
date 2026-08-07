set -euo pipefail
if command -v apt >/dev/null 2>&1; then
  sudo apt update && sudo apt upgrade
fi
if command -v rpm-ostree >/dev/null 2>&1; then
  sudo rpm-ostree update
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf update
fi
if command -v snap >/dev/null 2>&1; then
  sudo snap refresh
fi
if command -v flatpak >/dev/null 2>&1; then
  flatpak update
fi
if command -v brew >/dev/null 2>&1; then
  brew update && brew upgrade
fi
if command -v dpkg wget jq >/dev/null 2>&1 &&
  dpkg -s proton-pass >/dev/null 2>&1; then
  (
    trap 'rm -f ProtonPass.deb' 0 1 2 15
    metadata=$(wget -qO- https://proton.me/download/PassDesktop/linux/x64/version.json) &&
      online_version=$(printf '%s' "$metadata" | jq -er 'first(.Releases[] | select(.CategoryName == "Stable")) | .Version') &&
      installed_version=$(dpkg-query -W -f='${Version}' proton-pass) &&
      if [ "$installed_version" != "$online_version" ]; then
        package_url=$(printf '%s' "$metadata" | jq -er 'first(.Releases[] | select(.CategoryName == "Stable") | .File[] | select(.Identifier | startswith(".deb"))) | .Url') &&
          wget -O ProtonPass.deb "$package_url" &&
          sudo dpkg -i ProtonPass.deb
      fi
  )
fi
if command -v rpm wget jq >/dev/null 2>&1 &&
  rpm -q proton-pass >/dev/null 2>&1; then
  (
    trap 'rm -f ProtonPass.rpm' 0 1 2 15
    metadata=$(wget -qO- https://proton.me/download/PassDesktop/linux/x64/version.json) &&
      online_version=$(printf '%s' "$metadata" | jq -er 'first(.Releases[] | select(.CategoryName == "Stable")) | .Version') &&
      installed_version=$(rpm -q --qf '%{VERSION}' proton-pass) &&
      if [ "$installed_version" != "$online_version" ]; then
        package_url=$(printf '%s' "$metadata" | jq -er 'first(.Releases[] | select(.CategoryName == "Stable") | .File[] | select(.Identifier | startswith(".rpm"))) | .Url') &&
          wget -O ProtonPass.rpm "$package_url" &&
          sudo rpm -U ProtonPass.rpm
      fi
  )
fi
