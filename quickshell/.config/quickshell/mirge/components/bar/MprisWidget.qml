import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

InteractiveRectangle {
  id: root
  visible: Mpris.players.values.length > 0
  onClicked: {
    if (player.canTogglePlaying) player.togglePlaying()
  }

  property MprisPlayer player: visible ? Mpris.players.values.find(p => p) : null
  readonly property color computedColor: player?.isPlaying ? Theme.green : Theme.fg

  rect.implicitHeight: bar.implicitHeight

  RowLayout {
    anchors.centerIn: parent
    spacing: 7

    StyledText {
      color: root.computedColor
      text: root.player?.identity || root.player?.trackTitle || ""
    }

    StyledText {
      color: root.computedColor
      text: root.player?.isPlaying ? "󰏤" : "󰐊"
      variant: "Propo"
    }
  }
}
