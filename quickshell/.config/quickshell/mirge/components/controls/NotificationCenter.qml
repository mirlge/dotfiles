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
      onClicked: {
        while (NotificationService.history.count > 0) {
          NotificationService.history.get(0).notification.dismiss()
          NotificationService.history.remove(0)
        }
      }

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

    NotificationCard { showExpired: true }
  }
}
