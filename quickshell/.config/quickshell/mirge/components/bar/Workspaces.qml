import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

RowLayout {
  spacing: 0

  Repeater {
    model: NiriService.workspaces

    WrapperMouseArea {
      onClicked: NiriService.focusWorkspaceById(ws.id)
      id: wsButton
      hoverEnabled: true
      required property var modelData

      property var ws: modelData
      property bool isActive: ws.isFocused
      property bool isActiveOnMonitor: ws.isActive

      implicitWidth: 36
      implicitHeight: bar.implicitHeight
      visible: ws.output === bar.screen.name

      Rectangle {
        color: wsButton.containsMouse ? Theme.dim : wsButton.isActive
          ? Theme.accent : "transparent"

        StyledText {
          id: label
          anchors.centerIn: parent
          text: wsButton.ws.index
          color: wsButton.isActive ? Theme.bg : wsButton.isActiveOnMonitor ? Theme.accent : wsButton.containsMouse ? Theme.fg : Theme.dim
        }
      }

      HoverHandler {
        cursorShape: Qt.PointingHandCursor
      }
    }
  }
}
