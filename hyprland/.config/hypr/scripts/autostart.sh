#!/usr/bin/env bash
systemctl --user start hyprpolkitagent.service
hypridle &
waypaper --restore &
wl-paste -t text --watch "$(dirname "$0")/clipman-keepassxc.sh" &
waybar &
swaync &
udiskie -t --appindicator &
swayosd-server &
avizo-service &
hyprpm reload -n
batsignal &
hyprswitch init
ulauncher --no-window-shadow --hide-window --dev &
systemctl --user start dex-autostart.service &
