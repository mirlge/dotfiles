#!/usr/bin/env bash
# $1: path to wallpaper
hyprctl eval 'hl.config({ misc = { disable_autoreload = true } })'
iris --compat wal --dark 1 "$1" || error_code="${?:-1}"
if [ -n "$error_code" ]; then
  hyprctl reload
  exit "$error_code"
fi
"$(dirname "$0")/restart_shell.sh"
hyprctl reload
