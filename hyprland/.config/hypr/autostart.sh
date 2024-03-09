#!/usr/bin/env bash
setxkbmap se
/usr/lib/polkit-kde-authentication-agent-1 &
hypridle &
hyprpaper &
waybar &
swaync &
udiskie -t &
avizo-service &
hyprpm reload -n
batsignal &
ulauncher --no-window-shadow --hide-window --dev &
dex -a &
