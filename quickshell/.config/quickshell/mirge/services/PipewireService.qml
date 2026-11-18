pragma Singleton
import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
  id: root

  // Output
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

  // Input
  property var source: Pipewire.defaultAudioSource
  readonly property bool sourceReady: source && source.ready
  readonly property bool sourceMuted: sourceReady && source.audio.muted
  readonly property int sourceVol: ready ? Math.round(source.audio.volume * 100) : 0

  readonly property string sourceIcon: {
    if (!sourceReady || sourceMuted) return "󰍭"
    if (sourceVol === 0) return "󰍮"
    return "󰍬"
  }

  PwObjectTracker {
    objects: [root.sink, root.source]
  }
}
