import Quickshell
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
  visible: showExpired || !modelData.expired

  required property var modelData
  required property int index
  property Notification notif: modelData.notification
  property bool critical: notif.urgency === NotificationUrgency.Critical
  property NotificationAction defaultAction: notif.actions.length > 0 ? notif.actions.find(a => a.identifier === "default") : null
  property real lastActionIdx: notif.actions.indexOf(defaultAction) === notif.actions.length - 1 ? notif.actions.length - 2 : notif.actions.length - 1
  property real firstActionIdx: notif.actions.indexOf(defaultAction) === 0 ? 1 : 0
  property bool showExpired: false

  Connections {
    target: card.notif
    function onClosed(_) {
      NotificationService.history.remove(card.index)
    }
  }

  Timer {
    interval: card.notif.expireTimeout < 0 ? 5000 : card.notif.expireTimeout * 1000
    running: !card.showExpired && card.visible && !card.critical && card.notif.expireTimeout !== 0
    onTriggered: {
      if (card.notif.transient) {
        card.notif.expire()
      } else NotificationService.history.setProperty(card.index, "expired", true)
    }
  }

  ColumnLayout {
    id: cardColumn
    anchors.fill: parent

    WrapperMouseArea {
      Layout.fillWidth: true
      acceptedButtons: Qt.LeftButton | Qt.MiddleButton
      onClicked: m => {
        if (m.button === Qt.LeftButton && card.defaultAction) card.defaultAction.invoke()
        else card.notif.dismiss()
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
          visible: status === Image.Ready
          source: card.notif.image || Quickshell.iconPath(card.notif.appIcon, true) || ""
        }

        ColumnLayout {
          Layout.fillWidth: true
          spacing: 2

          StyledText {
            Layout.fillWidth: true
            color: card.critical ? Theme.red : Theme.accent
            elide: Text.ElideRight
            text: card.notif.summary
            wrapMode: Text.WordWrap
            font.bold: true
          }

          StyledText {
            Layout.fillWidth: true
            visible: text !== ""
            wrapMode: Text.WordWrap
            text: card.notif.body
          }

          StyledText {
            visible: card.showExpired
            color: Theme.dim
            text: card.notif.appName || ""
          }
        }

        StyledText {
          Layout.alignment: Qt.AlignTop
          color: Theme.dim
          text: card.modelData.time
          visible: card.showExpired
        }

        WrapperMouseArea {
          Layout.alignment: Qt.AlignTop
          onClicked: {
            card.notif.dismiss()
          }

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
            onClicked: {
              parent.modelData.invoke()
            }
          }
        }
      }
    }
  }
}
