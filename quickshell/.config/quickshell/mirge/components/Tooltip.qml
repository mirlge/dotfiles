import Quickshell
import Quickshell.Widgets
import QtQuick
import qs.services

PopupWindow {
  id: root
  color: "transparent"
  implicitHeight: rect.implicitHeight
  implicitWidth: rect.implicitWidth

  required property bool hovered
  default property list<QtObject> extraData

  property color bg: Theme.surface
  property real delay: 1000

  Timer {
    interval: root.delay
    running: root.hovered
    onTriggered: root.visible = true
  }

  Timer {
    interval: 100
    running: !root.hovered && !mouse.containsMouse
    onTriggered: root.visible = false
  }

  WrapperRectangle {
    id: rect
    color: root.bg
    radius: 5
    border.width: 1
    border.color: Theme.dim
    data: root.extraData
  }

  MouseArea {
    id: mouse
    anchors.fill: parent
    hoverEnabled: true
  }
}
