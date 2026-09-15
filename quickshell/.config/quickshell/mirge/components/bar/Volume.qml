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

    StyledText {
      text: PipewireService.ready ? PipewireService.vol + "%" : "–"
      color: PipewireService.muted ? Theme.fg : Theme.yellow
    }

    StyledText {
      text: PipewireService.icon
      color: PipewireService.muted ? Theme.fg : Theme.yellow
      variant: "Propo"
    }
  }
}
