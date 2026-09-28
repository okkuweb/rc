#!/bin/bash
set -euo pipefail
if command -v apt >/dev/null 2>&1; then
  echo "======== Updating apt packages ========"
  sudo apt update && sudo apt upgrade
  echo "======== Updated apt packages ========"
fi
if command -v rpm-ostree >/dev/null 2>&1; then
  echo "======== Checking for rpm-ostree updates ========"
  # --check returns 77 when no update is available, without pulling the image.
  if rpm-ostree upgrade --check; then
    echo "======== Updating rpm-ostree packages ========"
    sudo rpm-ostree upgrade
    echo "======== Updated rpm-ostree packages ========"
  else
    rpm_ostree_status=$?
    if [ "$rpm_ostree_status" -eq 77 ]; then
      echo "======== rpm-ostree packages already up-to-date ========"
    else
      exit "$rpm_ostree_status"
    fi
  fi
elif command -v dnf >/dev/null 2>&1; then
  echo "======== Updating dnf packages ========"
  sudo dnf update
  echo "======== Updated dnf packages ========"
fi
if command -v snap >/dev/null 2>&1; then
  echo "======== Updating snaps ========"
  sudo snap refresh
  echo "======== Updated snaps ========"
fi
if command -v flatpak >/dev/null 2>&1; then
  echo "======== Updating flatpaks ========"
  flatpak update
  echo "======== Updated flatpaks ========"
fi
if command -v brew >/dev/null 2>&1; then
  echo "======== Updating brew packages ========"
  brew update && brew upgrade
  echo "======== Updated brew packages ========"
fi
if command -v dpkg wget jq >/dev/null 2>&1 &&
  dpkg -s proton-pass >/dev/null 2>&1; then
  (
    trap 'rm -f ProtonPass.deb' 0 1 2 15
    metadata=$(wget -qO- https://proton.me/download/PassDesktop/linux/x64/version.json) &&
      online_version=$(printf '%s' "$metadata" | jq -er 'first(.Releases[] | select(.CategoryName == "Stable")) | .Version') &&
      installed_version=$(dpkg-query -W -f='${Version}' proton-pass) &&
      if [ "$installed_version" != "$online_version" ]; then
          echo "======== Updating Proton Pass ========"
          package_url=$(printf '%s' "$metadata" | jq -er 'first(.Releases[] | select(.CategoryName == "Stable") | .File[] | select(.Identifier | startswith(".deb"))) | .Url') &&
              wget -O ProtonPass.deb "$package_url" &&
              sudo dpkg -i ProtonPass.deb
          echo "======== Updated Proton Pass ========"
      else
          echo "======== Proton Pass already up-to-date ========"
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
          echo "======== Updating Proton Pass ========"
          package_url=$(printf '%s' "$metadata" | jq -er 'first(.Releases[] | select(.CategoryName == "Stable") | .File[] | select(.Identifier | startswith(".rpm"))) | .Url') &&
              wget -O ProtonPass.rpm "$package_url" &&
              sudo rpm -U ProtonPass.rpm
          echo "======== Updated Proton Pass ========"
      else
          echo "======== Proton Pass already up-to-date ========"
      fi
  )
fi
