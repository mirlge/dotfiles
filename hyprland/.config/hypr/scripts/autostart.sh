#!/usr/bin/env bash
systemctl --user start hyprpolkitagent.service
uwsm app -- hypridle &
uwsm app -- waypaper --restore &
wl-paste -t text --watch "$(dirname "$0")/clipman-keepassxc.sh" &
XDG_DATA_DIRS="${XDG_CONFIG_HOME:-$HOME/.config}/waybar/better_icons:$XDG_DATA_DIRS" uwsm app -- waybar &
uwsm app -- swaync &
uwsm app -- udiskie -t --appindicator &
uwsm app -- swayosd-server &
uwsm app -- avizo-service &
hyprpm reload -n
uwsm app -- hyprkool daemon &
uwsm app -- batsignal &
uwsm app -- elephant &
uwsm app -- walker --gapplication-service &
