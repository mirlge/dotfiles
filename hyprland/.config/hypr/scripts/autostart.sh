#!/usr/bin/env bash
systemctl --user start hyprpolkitagent.service || ! pidof hyprpolkitagent && /usr/lib/polkit-kde-authentication-agent-1 &
hypridle &
waypaper --restore &
waybar &
swaync &
udiskie -t --appindicator &
avizo-service &
hyprpm reload -n
batsignal &
ulauncher --no-window-shadow --hide-window --dev &
systemctl --user start dex-autostart.service &
