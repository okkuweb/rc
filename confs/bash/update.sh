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
  # Check each existing installation without sudo or installing updates.
  for flatpak_scope in user system; do
    if [ "$flatpak_scope" = user ]; then
      flatpak_dir=${FLATPAK_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/flatpak}
    else
      flatpak_dir=${FLATPAK_SYSTEM_DIR:-/var/lib/flatpak}
    fi
    if [ ! -d "$flatpak_dir/repo" ]; then
      echo "======== No $flatpak_scope Flatpak repository; skipping ========"
      continue
    fi

    echo "======== Checking for $flatpak_scope Flatpak updates ========"
    flatpak_updates=$(flatpak remote-ls "--$flatpak_scope" --updates --all --columns=ref)
    if [ -n "$flatpak_updates" ]; then
      printf '%s\n' "$flatpak_updates"
      echo "======== Updating $flatpak_scope flatpaks ========"
      if [ "$flatpak_scope" = system ] && ! command -v rpm-ostree >/dev/null 2>&1; then
        sudo flatpak update --system --assumeyes --noninteractive
      else
        flatpak update "--$flatpak_scope" --assumeyes --noninteractive
      fi
      echo "======== Updated $flatpak_scope flatpaks ========"
    else
      echo "======== $flatpak_scope flatpaks already up-to-date ========"
    fi
  done
fi
if command -v brew >/dev/null 2>&1; then
  echo "======== Updating brew packages ========"
  brew update && brew upgrade --no-ask
  echo "======== Updated brew packages ========"
fi

find_update_repos() {
  local fd_name fd_command
  for fd_name in fd fdfind fd-find; do
    if fd_command=$(type -P "$fd_name"); then
      "$fd_command" --type d --max-depth 2 --hidden --no-ignore \
        --case-sensitive --print0 '^(rc|prc)$' "$HOME"
      return
    fi
  done
  find "$HOME" -mindepth 1 -maxdepth 2 -type d \
    \( -name rc -o -name prc \) -print0
}

while IFS= read -r -d '' repo_dir; do
  echo "======== Updating $repo_dir ========"
  previous_commit=$(git -C "$repo_dir" rev-parse HEAD)
  git -C "$repo_dir" pull
  current_commit=$(git -C "$repo_dir" rev-parse HEAD)

  if [[ "$previous_commit" != "$current_commit" ]]; then
    echo "======== Changes pulled; running link.sh for $repo_dir ========"
    (cd "$repo_dir" && ./link.sh)
  else
    echo "======== No changes pulled; skipping link.sh for $repo_dir ========"
  fi
done < <(find_update_repos)
