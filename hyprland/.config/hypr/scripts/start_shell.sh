#!/usr/bin/env bash
start_polkitagent() {
  systemctl --user start hyprpolkitagent.service
}
start_idle() {
  uwsm app -- hypridle &
}
start_waypaper() {
  uwsm app -- waypaper --restore --no-post-command &
}
start_clipman() {
  wl-paste -t text --watch "$(dirname "$0")/clipman-keepassxc.sh" &
}
start_bar() {
  XDG_DATA_DIRS="${XDG_CONFIG_HOME:-$HOME/.config}/waybar/better_icons:$XDG_DATA_DIRS" uwsm app -- waybar &
}
start_notifications() {
  uwsm app -- swaync &
}
start_osd() {
  uwsm app -- swayosd-server &
  uwsm app -- avizo-service &
}
start_hyprkool() {
  uwsm app -- hyprkool daemon &
}
start_launcher() {
  uwsm app -- elephant &
  uwsm app -- walker --gapplication-service &
}

start_all() {
  start_polkitagent
  start_idle
  [ -z "$KEEP_WAYPAPER" ] && start_waypaper
  start_clipman
  start_bar
  start_notifications
  start_osd
  start_hyprkool
  start_batsignal
  start_launcher
}

eval "start_${*:-all}"
