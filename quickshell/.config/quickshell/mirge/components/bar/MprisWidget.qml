import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

InteractiveRectangle {
  id: root
  visible: Mpris.players.values.length > 0
  onClicked: {
    if (player?.canTogglePlaying) player.togglePlaying()
  }

  property MprisPlayer player: visible ? Mpris.players.values.find(p => p) : null
  readonly property bool isPlaying: player?.isPlaying
  readonly property color computedColor: isPlaying ? Theme.green : Theme.fg
  readonly property string playerName: player?.identity
  readonly property string title: player?.trackTitle
  readonly property string artURL: player?.trackArtUrl
  readonly property string artist: player?.trackArtist

  rect.implicitHeight: bar.implicitHeight

  RowLayout {
    anchors.centerIn: parent
    spacing: 7

    StyledText {
      color: root.computedColor
      text: root.playerName || root.title || ""
    }

    StyledText {
      color: root.computedColor
      text: root.isPlaying ? "󰏤" : "󰐊"
      variant: "Propo"
    }

    Tooltip {
      anchor {
        window: bar
        item: root
        margins.top: bar.implicitHeight
      }
      hovered: root.containsMouse

      RowLayout {
        IconImage {
          implicitSize: tooltipTitle.implicitHeight < 50 ? 50 : tooltipTitle.implicitHeight
          source: root.artURL || ""
          visible: source !== ""
        }

        StyledText {
          id: tooltipTitle
          text: root.title + " – " + root.artist || ""
        }
      }
    }
  }
}
