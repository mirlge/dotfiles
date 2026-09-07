pragma Singleton
import Quickshell
import Quickshell.Wayland
import QtQuick

IdleInhibitor {
  window: PanelWindow {
    implicitWidth: 0
    implicitHeight: 0
    color: "transparent"
    anchors {
      right: true
      bottom: true
    }
    mask: Region {
      item: null
    }
  }
}
