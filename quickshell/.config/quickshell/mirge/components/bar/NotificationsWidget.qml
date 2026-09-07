import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

InteractiveRectangle {
  id: root
  onClicked: controls.visible = !controls.visible

  readonly property int count: NotificationService.history.count
  readonly property string icon: count > 0 ? "󱅫" : "󰂜"
  readonly property color computedColor: count > 0 ? Theme.accent : Theme.fg

  rect.implicitHeight: bar.implicitHeight

  RowLayout {
    anchors.centerIn: parent

    StyledText {
      color: root.computedColor
      text: root.count
    }

    StyledText {
      color: root.computedColor
      text: root.icon
      variant: "Propo"
    }
  }
}
