import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

ColumnLayout {
  id: column
  Layout.fillWidth: true
  spacing: 10

  Connections {
    target: controls
    function onVisibleChanged() {
      if (visible) {
        for (let i = 0, removed = 0; i - removed < NotificationService.history.count; i++) {
          let new_i = i - removed
          let n = NotificationService.history.get(new_i)

          if (n.notification.transient) {
            n.notification.dismiss()
            removed++
          } else n.expired = true
        }
      }
    }
  }

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
