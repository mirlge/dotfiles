#!/usr/bin/env bash
stop_polkit() {
  systemctl --user stop hyprpolkitagent.service
}
stop_idle() {
  killall hypridle
}
stop_waypaper() {
  killall hyprpaper swaybg
}
stop_clipman() {
  killall wl-paste
}
stop_bar() {
  killall waybar
}
stop_notifications() {
  killall swaync
}
stop_osd() {
  killall swayosd-server
  killall avizo-service
}
stop_launcher() {
  killall elephant
  killall walker
}

stop_all() {
  stop_polkitagent
  stop_idle
  [ -z "$KEEP_WAYPAPER" ] && stop_waypaper
  stop_clipman
  stop_bar
  stop_notifications
  stop_osd
  stop_batsignal
  stop_launcher
}

eval "stop_${*:-all}"
