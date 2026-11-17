#!/usr/bin/env bash
app_id="$(niri msg focused-window | grep '^\s*App ID:' | awk -F': "' '{print $2}' | sed 's/"$//')"
if [[ "$app_id" != '"org.keepassxc.KeePassXC"' ]]; then
  clipman store
fi
