import Quickshell.Widgets
import Quickshell.Services.Notifications
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

    Rectangle {
      id: card
      Layout.fillWidth: true
      Layout.preferredHeight: layout.implicitHeight + 20
      radius: 10
      color: Theme.surface
      border.width: 1
      border.color: critical ? Theme.red : Theme.dim

      required property var modelData
      required property var index
      property bool critical: modelData.notification.urgency === NotificationUrgency.critical

      RowLayout {
        id: layout
        anchors {
          fill: parent
          margins: 10
        }
        spacing: 10

        IconImage {
          implicitSize: 36
          Layout.alignment: Qt.AlignCenter
          visible: source.toString() !== ""
          source: card.modelData.notification.image || card.modelData.notification.appIcon || ""
        }

        ColumnLayout {
          Layout.fillWidth: true
          spacing: 2

          StyledText {
            Layout.fillWidth: true
            color: card.critical ? Theme.red : Theme.accent
            elide: Text.ElideRight
            text: card.modelData.notification.summary
            font.bold: true
          }

          StyledText {
            Layout.fillWidth: true
            visible: text !== ""
            wrapMode: Text.WordWrap
            text: card.modelData.notification.body
          }

          StyledText {
            visible: text !== ""
            color: Theme.dim
            text: card.modelData.notification.appName || ""
          }
        }

        StyledText {
          Layout.alignment: Qt.AlignTop
          color: Theme.dim
          text: card.modelData.time
        }

        WrapperMouseArea {
          Layout.alignment: Qt.AlignTop
          onClicked: NotificationService.history.remove(card.index)

          StyledText {
            color: Theme.dim
            text: "X"
          }
        }
      }
    }
  }
}
