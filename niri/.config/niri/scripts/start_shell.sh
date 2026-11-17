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
start_quickshell() {
  uwsm app -- qs -nc mirge &
}
start_osd() {
  uwsm app -- swayosd-server &
  uwsm app -- avizo-service &
}
start_batsignal() {
  systemctl --user start batsignal.service
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
  start_quickshell
  start_osd
  start_batsignal
  start_launcher
}

eval "start_${1:-all}"
