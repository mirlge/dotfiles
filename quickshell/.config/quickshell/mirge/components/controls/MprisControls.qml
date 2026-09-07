import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

ColumnLayout {
  Repeater {
    model: Mpris.players

    RowLayout {
      id: root
      spacing: 10
      required property MprisPlayer modelData

      IconImage {
        implicitSize: column.implicitHeight
        source: root.modelData.trackArtUrl || ""
        visible: source !== ""
      }

      ColumnLayout {
        id: column

        StyledText {
          color: Theme.accent
          Layout.fillWidth: true
          wrapMode: Text.WordWrap
          text: root.modelData.trackTitle || root.modelData.identity
          font.bold: true
        }

        StyledText {
          text: Math.floor(root.modelData.position) + "/" + Math.floor(root.modelData.length)
          visible: root.modelData.canSeek && root.modelData.positionSupported

          Timer {
            running: parent.visible && root.modelData.playbackState === MprisPlaybackState.Playing
            interval: 1000
            repeat: true
            onTriggered: root.modelData.positionChanged()
          }
        }

        RowLayout {
          InteractiveRectangle {
            onClicked: root.modelData.previous()
            visible: root.modelData.canGoPrevious
            rect.leftMargin: 5
            rect.rightMargin: 5

            StyledText {
              anchors.centerIn: parent
              text: "󰒮"
              variant: "Propo"
            }
          }

          InteractiveRectangle {
            onClicked: root.modelData.togglePlaying()
            visible: root.modelData.canTogglePlaying
            rect.leftMargin: 5
            rect.rightMargin: 5

            StyledText {
              anchors.centerIn: parent
              text: root.modelData.isPlaying ? "󰏤" : "󰐊"
              variant: "Propo"
            }
          }

          InteractiveRectangle {
            onClicked: root.modelData.stop()
            visible: root.modelData.canControl && root.modelData.playbackState !== MprisPlaybackState.Stopped
            rect.leftMargin: 5
            rect.rightMargin: 5

            StyledText {
              anchors.centerIn: parent
              text: "󰓛"
              variant: "Propo"
            }
          }

          InteractiveRectangle {
            onClicked: root.modelData.next()
            visible: root.modelData.canGoNext
            rect.leftMargin: 5
            rect.rightMargin: 5

            StyledText {
              anchors.centerIn: parent
              text: "󰒭"
              variant: "Propo"
            }
          }
        }
      }
    }
  }
}
