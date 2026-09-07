import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

RowLayout {
  spacing: 0

  Repeater {
    model: Hyprland.workspaces

    WrapperMouseArea {
      onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + wsButton.ws.id + " })")
      id: wsButton
      hoverEnabled: true
      required property var modelData

      property var ws: modelData
      property bool isActive: ws.focused

      implicitWidth: 36
      implicitHeight: bar.implicitHeight
      visible: ws.id > 0 && ws.monitor.name === bar.screen.name

      Rectangle {
        color: wsButton.containsMouse ? Theme.dim : wsButton.isActive
          ? Theme.accent : "transparent"

        StyledText {
          id: label
          anchors.centerIn: parent
          text: wsButton.ws.id
          color: wsButton.isActive ? Theme.bg : Theme.fg
        }
      }

      HoverHandler {
        cursorShape: Qt.PointingHandCursor
      }
    }
  }
}
