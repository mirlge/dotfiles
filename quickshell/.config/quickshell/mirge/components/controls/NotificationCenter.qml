import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

ColumnLayout {
  id: column
  Layout.fillWidth: true
  spacing: 10
  onControlsVisibleChanged: {
    if (controlsVisible) {
      for (let i = 0, removed = 0; i - removed < NotificationService.history.count; i++) {
        let new_i = i - removed
        let n = NotificationService.history.get(new_i)

        if (n.notification.transient) {
          n.notification.dismiss()
          NotificationService.history.remove(new_i)
          removed++
        } else n.expired = true
      }
    }
  }

  readonly property bool controlsVisible: controls.visible

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
