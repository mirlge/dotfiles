import QtQuick
import qs.services
import qs.components

InteractiveRectangle {
  id: root
  onClicked: InhibitorIdle.enabled = !active
  readonly property bool active: InhibitorIdle.enabled
  rect.implicitHeight: bar.implicitHeight

  StyledText {
    verticalAlignment: Text.AlignVCenter
    color: root.active || root.containsMouse ? Theme.fg : Theme.dim
    text: root.active ? "󰅶" : "󰾫"
    variant: "Propo"
  }
}
