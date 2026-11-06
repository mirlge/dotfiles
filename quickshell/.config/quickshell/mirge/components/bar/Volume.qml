import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

WrapperItem {
  RowLayout {
    id: root
    spacing: 7
    anchors.centerIn: parent

    property color computedColor: PipewireService.muted ? Theme.dim : Theme.yellow

    StyledText {
      text: PipewireService.ready ? PipewireService.vol + "%" : "–"
      color: root.computedColor
    }

    StyledText {
      text: PipewireService.icon
      color: root.computedColor
      variant: "Propo"
    }
  }
}
