#!/usr/bin/env bash
dbus-update-activation-environment --systemd --all
systemctl --user import-environment QT_QPA_PLATFORMTHEME
"$(dirname "$0")/start_shell.sh"
uwsm app -- udiskie -t --appindicator &
