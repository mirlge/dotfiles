import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

WrapperItem {
  RowLayout {
    id: root
    spacing: 7
    anchors.centerIn: parent

    property var sink: Pipewire.defaultAudioSink

    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0

    readonly property string icon: {
      if (!ready) return "󰖁"
      if (muted) return "󰝟"
      if (vol === 0) return "󰕿"
      if (vol < 50) return "󰖀"
      return "󰕾"
    }

    StyledText {
      text: root.ready ? root.vol + "%" : "–"
      color: root.muted ? Theme.fg : Theme.yellow
    }

    StyledText {
      text: root.icon
      color: root.muted ? Theme.fg : Theme.yellow
      variant: "Propo"
    }
  }

  PwObjectTracker {
    objects: [root.sink]
  }
}
