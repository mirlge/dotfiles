#!/usr/bin/env bash
systemctl --user start hyprpolkitagent.service
hypridle &
waypaper --restore &
wl-paste -t text --watch "$(dirname "$0")/clipman-keepassxc.sh" &
waybar &
swaync &
uwsm app -- udiskie -t --appindicator &
swayosd-server &
avizo-service &
hyprpm reload -n
uwsm app -- batsignal &
uwsm app -- ulauncher --no-window-shadow --hide-window --dev &
