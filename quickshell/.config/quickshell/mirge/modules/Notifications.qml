import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
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

        Rectangle {
          id: card
          Layout.fillWidth: true
          Layout.preferredHeight: cardColumn.implicitHeight + 20
          radius: 10
          color: Theme.surface
          border.width: 1
          border.color: critical ? Theme.red : Theme.dim

          required property Notification modelData
          property bool critical: modelData.urgency === NotificationUrgency.Critical
          property NotificationAction defaultAction: modelData.actions.length > 0 ? modelData.actions.find(a => a.identifier === "default") : null
          property real lastActionIdx: modelData.actions.indexOf(defaultAction) === modelData.actions.length - 1 ? modelData.actions.length - 2 : modelData.actions.length - 1
          property real firstActionIdx: modelData.actions.indexOf(defaultAction) === 0 ? 1 : 0

          Timer {
            interval: card.modelData.expireTimeout > 0 ? card.modelData.expireTimeout * 1000 : 5000
            running: !card.critical && card.modelData.expireTimeout >= 0 && card.modelData.actions.length === 0
            onTriggered: card.modelData.expire()
          }

          ColumnLayout {
            id: cardColumn
            anchors.fill: parent

            WrapperMouseArea {
              Layout.fillWidth: true
              onClicked: {
                if (card.defaultAction) card.defaultAction.invoke()
                else card.modelData.dismiss()
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
                  source: card.modelData.image || card.modelData.appIcon || ""
                }

                ColumnLayout {
                  Layout.fillWidth: true
                  spacing: 2

                  StyledText {
                    Layout.fillWidth: true
                    color: critical ? Theme.red : Theme.accent
                    elide: Text.ElideRight
                    text: card.modelData.summary
                    font.bold: true
                  }

                  StyledText {
                    Layout.fillWidth: true
                    visible: text !== ""
                    wrapMode: Text.WordWrap
                    text: card.modelData.body
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
                model: card.modelData.actions

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
      }
    }
  }
}
