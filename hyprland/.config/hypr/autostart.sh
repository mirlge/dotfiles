#!/usr/bin/env bash
setxkbmap se
/usr/lib/polkit-kde-authentication-agent-1 &
hyprpaper &
waybar &
swaync &
udiskie -t &
avizo-service &
hyprpm reload -n
ulauncher --no-window-shadow --hide-window --dev &
#xwaylandvideobridge &
#brave &
dex -a &
