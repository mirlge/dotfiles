#!/usr/bin/env bash
# $1: path to wallpaper
iris --compat wal --dark 1 "$1" || exit $?
[ -z "$KEEP_WAYPAPER" ] && waypaper --wallpaper "$1"
niri msg action spawn-sh -- KEEP_WAYPAPER=1 bash "$(dirname "$0")/restart_shell.sh"
