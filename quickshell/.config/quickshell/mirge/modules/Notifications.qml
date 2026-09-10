import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

Variants {
  model: Quickshell.screens

  PanelWindow {
    anchors { top: true; right: true }
    margins { top: 12 + Config.barHeight; right: 12 }

    implicitWidth: 380
    implicitHeight: Math.max(1, column.implicitHeight)
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    screen: modelData

    required property var modelData

    ColumnLayout {
      id: column
      width: parent.width
      spacing: 10

      Repeater {
        model: NotificationService.trackedNotifications

        NotificationCard { index: -1 }
      }
    }
  }
}
