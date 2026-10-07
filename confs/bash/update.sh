#!/bin/bash
set -euo pipefail
if command -v apt >/dev/null 2>&1; then
  (
    echo "======== Checking for apt updates ========"
    # Refresh private package lists without writing to root-owned APT state.
    apt_check_dir=$(mktemp -d)
    trap 'rm -rf -- "$apt_check_dir"' EXIT
    mkdir -p "$apt_check_dir/lists/partial"
    # System update hooks may require root; only run them during sudo apt update.
    cat > "$apt_check_dir/apt.conf" <<'EOF'
#clear APT::Update::Pre-Invoke;
#clear APT::Update::Post-Invoke;
#clear APT::Update::Post-Invoke-Success;
EOF
    apt_check_options=(
      -c "$apt_check_dir/apt.conf"
      -o "Dir::State::lists=$apt_check_dir/lists"
      -o 'Dir::Cache::pkgcache='
      -o 'Dir::Cache::srcpkgcache='
      -o 'APT::Update::Error-Mode=any'
    )
    apt-get "${apt_check_options[@]}" update
    apt_updates=$(LC_ALL=C apt-get "${apt_check_options[@]}" --simulate --with-new-pkgs upgrade)
    if grep -q '^Inst ' <<< "$apt_updates"; then
      echo "======== Updating apt packages ========"
      sudo apt update
      sudo apt upgrade -y
      echo "======== Updated apt packages ========"
    else
      echo "======== apt packages already up-to-date ========"
    fi
  )
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
  echo "======== Checking for dnf updates ========"
  # DNF returns 100 when updates are available, 0 when there are none.
  if dnf --refresh check-update; then
    echo "======== dnf packages already up-to-date ========"
  else
    dnf_status=$?
    if [ "$dnf_status" -eq 100 ]; then
      echo "======== Updating dnf packages ========"
      sudo dnf --refresh update -y
      echo "======== Updated dnf packages ========"
    else
      exit "$dnf_status"
    fi
  fi
fi
if command -v snap >/dev/null 2>&1; then
  echo "======== Checking for snap updates ========"
  snap_updates=$(LC_ALL=C snap refresh --list)
  if grep -q '^Name[[:space:]]' <<< "$snap_updates"; then
    printf '%s\n' "$snap_updates"
    echo "======== Updating snaps ========"
    sudo snap refresh
    echo "======== Updated snaps ========"
  else
    echo "======== snaps already up-to-date ========"
  fi
fi
if command -v flatpak >/dev/null 2>&1; then
  echo "======== Updating flatpaks ========"
  flatpak update --assumeyes --noninteractive
  echo "======== Updated flatpaks ========"
fi
if command -v brew >/dev/null 2>&1; then
  echo "======== Updating brew packages ========"
  brew update && brew upgrade --no-ask
  echo "======== Updated brew packages ========"
fi
