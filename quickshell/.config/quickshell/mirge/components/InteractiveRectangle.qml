import Quickshell.Widgets
import QtQuick
import qs.services

WrapperMouseArea {
  id: root
  hoverEnabled: true
  default property Item rectChild
  property alias rect: rect

  WrapperRectangle {
    id: rect
    color: root.containsMouse ? Theme.dim : "transparent"
    child: root.rectChild
  }
}
