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
      onVisibleChanged: { if (visible) root.modelData.positionChanged() }

      required property MprisPlayer modelData
      readonly property string artURL: modelData.trackArtUrl
      readonly property string title: modelData.trackTitle
      readonly property string playerName: modelData.identity

      readonly property bool isPlaying: modelData.isPlaying
      readonly property bool canSeek: modelData.canSeek
      readonly property bool canControl: modelData.canControl
      readonly property bool canGoPrevious: modelData.canGoPrevious
      readonly property bool canGoNext: modelData.canGoNext
      readonly property bool canTogglePlaying: modelData.canTogglePlaying
      readonly property bool positionSupported: modelData.positionSupported

      readonly property real position: modelData.position
      readonly property real length: modelData.length
      readonly property var playState: modelData.playbackState

      function positionFormat(seconds) {
        let hours = Math.floor(seconds / 3600)
        let format = (hours === 0 ? "" : "HH:") + "mm:ss"
        let date = new Date(2026, 0, 1, 0, 0, seconds)
        return Qt.formatTime(date, format)
      }

      IconImage {
        implicitSize: column.implicitHeight
        source: root.artURL || ""
        visible: source !== ""
      }

      ColumnLayout {
        id: column

        StyledText {
          color: Theme.accent
          Layout.fillWidth: true
          wrapMode: Text.WordWrap
          text: root.title || root.playerName
          font.bold: true
        }

        StyledText {
          color: root.isPlaying ? Theme.fg : Theme.dim
          text: root.positionFormat(root.position) + "/" + root.positionFormat(root.length)
          visible: root.canSeek && root.positionSupported

          Timer {
            running: parent.visible && root.playState === MprisPlaybackState.Playing
            interval: 1000
            repeat: true
            onTriggered: root.modelData.positionChanged()
          }
        }

        RowLayout {
          InteractiveRectangle {
            onClicked: root.modelData.previous()
            visible: root.canGoPrevious
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
            visible: root.canTogglePlaying
            rect.leftMargin: 5
            rect.rightMargin: 5

            StyledText {
              anchors.centerIn: parent
              text: root.isPlaying ? "󰏤" : "󰐊"
              variant: "Propo"
            }
          }

          InteractiveRectangle {
            onClicked: root.modelData.stop()
            visible: root.canControl && root.playState !== MprisPlaybackState.Stopped
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
            visible: root.canGoNext
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
