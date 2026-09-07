import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components.bar

Variants {
  model: Quickshell.screens

  PanelWindow {
    id: bar

    required property var modelData
    screen: modelData

    anchors {
      top: true
      left: true
      right: true
    }
    implicitHeight: Config.barHeight
    color: Theme.surface

    RowLayout {
      anchors.fill: parent
      anchors.rightMargin: 10

      Workspaces {}

      Item { Layout.fillWidth: true }

      RowLayout {
        id: modules_left
        spacing: 20

        Tray {}
        Volume {}
        MprisWidget {}
        IdleInhibitorWidget {}
        Battery {}
        Clock {}
        NotificationsWidget {}
      }
    }
  }
}
