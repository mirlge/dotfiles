#!/usr/bin/env bash
stop_polkit() {
  systemctl --user stop plasma-polkit-agent.service
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
stop_quickshell() {
  [ "$1" = '-f' ] && qs -c mirge kill
}
stop_osd() {
  killall swayosd-server
}
stop_batsignal() {
  systemctl --user stop batsignal.service
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
  stop_quickshell "$2"
  stop_osd
  stop_batsignal
  stop_launcher
}

eval "stop_${1:-all}"
