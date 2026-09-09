import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

ColumnLayout {
  id: column
  Layout.fillWidth: true
  spacing: 10

  RowLayout {
    Layout.fillWidth: true

    StyledText {
      Layout.fillWidth: true
      color: Theme.accent
      text: "Notifications"
      font.pixelSize: 16
      font.bold: true
    }

    InteractiveRectangle {
      visible: NotificationService.history.count > 0
      onClicked: NotificationService.history.clear()

      StyledText {
        color: Theme.red
        text: "Clear all"
        font.pixelSize: 16
        font.bold: true
      }
    }
  }

  Repeater {
    model: NotificationService.history

    NotificationCard {}
  }
}
