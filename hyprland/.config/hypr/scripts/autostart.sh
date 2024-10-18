#!/usr/bin/env bash
systemctl --user start hyprpolkitagent.service
hypridle &
waypaper --restore &
waybar &
swaync &
udiskie -t --appindicator &
swayosd-server &
avizo-service &
hyprpm reload -n
batsignal &
ulauncher --no-window-shadow --hide-window --dev &
systemctl --user start dex-autostart.service &
