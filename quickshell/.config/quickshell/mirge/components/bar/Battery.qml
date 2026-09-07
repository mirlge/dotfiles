import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

RowLayout {
  id: root
  spacing: 6

  property var battery: UPower.displayDevice
  property bool charging: battery.state === UPowerDeviceState.Charging
  readonly property int level: Math.round(battery.percentage * 100)

  readonly property color computedColor: root.charging ? Theme.green
      : root.level < Config.batteryCritical ? Theme.red
      : root.level <= Config.batteryWarning ? Theme.yellow
      : Theme.fg

  readonly property string icon: {
    if (charging) {
      if (level >= 100) return "󰂄"
      if (level >= 80) return String.fromCodePoint(0xF008A + Math.floor(level / 10) - 8)
      if (level >= 70) return "󰢞"
      if (level >= 60) return "󰂉"
      if (level >= 50) return "󰢝"
      if (level >= 20) return String.fromCodePoint(0xF0086 + Math.floor(level / 10) - 2)
      if (level >= 10) return "󰢜"
      return "󰢟"
    }
    if (level >= 100) return "󰁹"
    if (level < 10) return "󰂎"

    return String.fromCodePoint(0xF007A + Math.floor(level / 10) - 1)
  }

  StyledText {
    text: root.level + "%"
    color: root.computedColor
  }

  StyledText {
    text: root.icon
    color: root.computedColor
    variant: "Propo"
  }
}
