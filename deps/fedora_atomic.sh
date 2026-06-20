#!/bin/bash
. /etc/os-release
curl -fsSL "https://copr.fedorainfracloud.org/coprs/scottames/ghostty/repo/fedora-${VERSION_ID}/scottames-ghostty-fedora-${VERSION_ID}.repo" | sudo tee /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:scottames:ghostty.repo > /dev/null
rpm-ostree refresh-md
rpm-ostree install fcitx5 fcitx5-mozc fcitx5-gtk fcitx5-qt chayang ghostty
