#!/usr/bin/env bash
set -euo pipefail

if ! selection=$(
    printf '%s\0icon\x1f%s\n' \
        'Lock' system-lock-screen \
        'Sleep' system-suspend \
        'Reboot' system-reboot \
        'Shutdown' system-shutdown \
        'Logout' system-log-out \
        'Hibernate' system-suspend-hibernate |
        rofi -dmenu -no-sort -no-custom -format i -selected-row 0 -p Power
); then
    exit 0
fi

case "$selection" in
    0) exec swaylock -f ;;
    1) exec systemctl suspend ;;
    2) exec systemctl reboot ;;
    3) exec systemctl poweroff ;;
    4) exec swaymsg exit ;;
    5) exec systemctl hibernate ;;
esac
