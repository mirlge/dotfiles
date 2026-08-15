#!/usr/bin/env bash
"$(dirname "$0")/start_shell.sh"
uwsm app -- udiskie -t --appindicator &
hyprpm reload -n
