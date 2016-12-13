#!/bin/bash

set -e

_toggle_mouse() {
    old=$(tmux show -g | grep mouse | head -n 1 | cut -d' ' -f2)
    new=""

    if [ "$old" = "on" ]; then
      new="off"
    else
      new="on"
    fi

    tmux set -g mouse $new \;\
         display "mouse: $new"
}

_uptime() {
  case $(uname -s) in
    *Darwin*)
      boot=$(sysctl -q -n kern.boottime | awk -F'[ ,:]+' '{ print $4 }')
      now=$(date +%s)
      ;;
    *Linux*|*CYGWIN*)
      now=$(cut -d' ' -f1 < /proc/uptime)
      ;;
    *OpenBSD*)
      boot=$(sysctl -n kern.boottime)
      now=$(date +%s)
  esac
  # shellcheck disable=SC1004
  awk -v boot="$boot" -v now="$now" '
    BEGIN {
      uptime = now - boot
      d = int(uptime / 86400)
      h = int(uptime / 3600) % 24
      m = int(uptime / 60) % 60
      s = int(uptime) % 60

      system("tmux  set -g @uptime_d " d + 0 " \\; " \
                   "set -g @uptime_h " h + 0 " \\; " \
                   "set -g @uptime_m " m + 0 " \\; " \
                   "set -g @uptime_s " s + 0)
    }'
}

_loadavg() {
  case $(uname -s) in
    *Darwin*)
      LOADAVG="$(sysctl -q -n vm.loadavg | cut -d' ' -f2)"
      ;;
    *Linux*)
      LOADAVG="$(cut -d' ' -f1 < /proc/loadavg)"
      ;;
    *OpenBSD*)
      LOADAVG="$(sysctl -q -n vm.loadavg | cut -d' ' -f1)"
      ;;
  esac

  if (( $(echo "$LOADAVG > 2" |bc -l) )); then
      tmux set -g @loadavg "#[fg=colour196,bold,blink bg=colour52,bold] $LOADAVG"
  elif (( $(echo "$LOADAVG > 1" |bc -l) )); then
      tmux set -g @loadavg "#[fg=colour197,bold bg=colour242,bold] $LOADAVG"
  elif (( $(echo "$LOADAVG > 0.5" |bc -l) )); then
      tmux set -g @loadavg "#[fg=colour154,bg=colour243,bold] $LOADAVG"
  else
      tmux set -g @loadavg "#[fg=colour2,bg=colour243,bold] $LOADAVG"
  fi

}

_set_vars() {
  case "$status_left $status_right" in
    *'#{uptime_d}'*|*'#{uptime_h}'*|*'#{uptime_m}'*)
      status_left=$(echo "$status_left" | sed -E \
        -e 's/#\{(\?)?uptime_d/#\{\1@uptime_d/g' \
        -e 's/#\{(\?)?uptime_h/#\{\1@uptime_h/g' \
        -e 's/#\{(\?)?uptime_m/#\{\1@uptime_m/g' \
        -e 's/#\{(\?)?uptime_s/#\{\1@uptime_s/g')
      status_right=$(echo "$status_right" | sed -E \
        -e 's/#\{(\?)?uptime_d/#\{\1@uptime_d/g' \
        -e 's/#\{(\?)?uptime_h/#\{\1@uptime_h/g' \
        -e 's/#\{(\?)?uptime_m/#\{\1@uptime_m/g' \
        -e 's/#\{(\?)?uptime_s/#\{\1@uptime_s/g')
      status_right="#($0 _uptime)$status_right"
      ;;
  esac

  case "$status_left $status_right" in
    *'#{loadavg}'*)
      status_left=$(echo "$status_left" | sed -E \
        -e 's/#\{(\?)?loadavg/#\{\1@loadavg/g')
      status_right=$(echo "$status_right" | sed -E \
        -e 's/#\{(\?)?loadavg/#\{\1@loadavg/g')
      status_right="#($0 _loadavg)$status_right"
      ;;
  esac

  tmux  set -g status-left-length 1000 \; set -g status-left "$status_left" \;\
        set -g status-right-length 1000 \; set -g status-right "$status_right"
}

_apply_configuration() {
  _set_vars
  for name in $(printenv | grep -Eo '^tmux_conf_[^=]+'); do tmux setenv -gu "$name"; done;
}

"$@"
