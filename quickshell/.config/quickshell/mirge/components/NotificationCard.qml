import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import qs.services

Rectangle {
  id: card
  Layout.fillWidth: true
  Layout.preferredHeight: cardColumn.implicitHeight + 20
  radius: 10
  color: Theme.surface
  border.width: 1
  border.color: critical ? Theme.red : Theme.dim

  required property var modelData
  required property int index
  property Notification notif: modelData.notification || modelData
  property bool critical: notif.urgency === NotificationUrgency.Critical
  property NotificationAction defaultAction: notif.actions.length > 0 ? notif.actions.find(a => a.identifier === "default") : null
  property real lastActionIdx: notif.actions.indexOf(defaultAction) === notif.actions.length - 1 ? notif.actions.length - 2 : notif.actions.length - 1
  property real firstActionIdx: notif.actions.indexOf(defaultAction) === 0 ? 1 : 0

  function dismiss() {
    if (card.index < 0) card.notif.dismiss()
    else NotificationService.history.remove(card.index)
  }

  Timer {
    interval: card.notif.expireTimeout > 0 ? card.notif.expireTimeout * 1000 : 5000
    running: !card.critical && card.notif.expireTimeout >= 0
    onTriggered: card.notif.expire()
  }

  ColumnLayout {
    id: cardColumn
    anchors.fill: parent

    WrapperMouseArea {
      Layout.fillWidth: true
      acceptedButtons: Qt.LeftButton | Qt.MiddleButton
      onClicked: m => {
        if (m.button === Qt.LeftButton && card.defaultAction) card.defaultAction.invoke()
        else card.dismiss()
        console.log(card.index)
        console.log(card.notif)
      }

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
          source: card.notif.image || card.notif.appIcon || ""
        }

        ColumnLayout {
          Layout.fillWidth: true
          spacing: 2

          StyledText {
            Layout.fillWidth: true
            color: card.critical ? Theme.red : Theme.accent
            elide: Text.ElideRight
            text: card.notif.summary
            font.bold: true
          }

          StyledText {
            Layout.fillWidth: true
            visible: text !== ""
            wrapMode: Text.WordWrap
            text: card.notif.body
          }

          StyledText {
            visible: card.index >= 0
            color: Theme.dim
            text: card.notif.appName || ""
          }
        }

        StyledText {
          Layout.alignment: Qt.AlignTop
          color: Theme.dim
          text: card.modelData.time || ""
          visible: text !== ""
        }

        WrapperMouseArea {
          Layout.alignment: Qt.AlignTop
          onClicked: card.dismiss()

          StyledText {
            color: Theme.dim
            text: "X"
          }
        }
      }
    }

    RowLayout {
      id: actions
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignBottom
      spacing: 0

      Repeater {
        model: card.notif.actions

        Rectangle {
          visible: modelData.identifier !== "default"
          Layout.fillWidth: true
          color: actionMouse.containsMouse ? Theme.dim : "transparent"
          implicitHeight: 30
          border {
            width: 1
            color: Theme.dim
          }
          bottomRightRadius: index === card.lastActionIdx ? card.radius : 0
          bottomLeftRadius: index === card.firstActionIdx ? card.radius : 0

          required property NotificationAction modelData
          required property var index

          StyledText {
            anchors.centerIn: parent
            text: parent.modelData.text || parent.modelData.identifier
          }

          MouseArea {
            id: actionMouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: parent.modelData.invoke()
          }
        }
      }
    }
  }
}
