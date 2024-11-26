#!/usr/bin/env bash
app_id=$(hyprctl activewindow -j | jq '.class')
if [[ "$app_id" != '"org.keepassxc.KeePassXC"' ]]; then
  clipman store
fi
