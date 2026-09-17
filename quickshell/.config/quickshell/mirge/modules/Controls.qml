import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components.controls

PanelWindow {
  id: root
  anchors {
    top: true
    bottom: true
    right: true
  }
  margins.top: Config.barHeight
  implicitWidth: 380
  visible: false
  color: "transparent"
  exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Overlay

  Rectangle {
    anchors.fill: parent
    color: Theme.surface

    ColumnLayout {
      anchors.margins: 12
      anchors {
        top: parent.top
        left: parent.left
        right: parent.right
      }

      MprisControls {}
      NotificationCenter {}
    }
  }

  IpcHandler {
    target: "controls"
    function toggle(): void { root.visible = !root.visible }
    function show(): void { root.visible = true }
    function hide(): void { root.visible = false }
  }
}
