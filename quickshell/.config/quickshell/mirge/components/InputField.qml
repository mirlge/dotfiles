import QtQuick
import qs.services

Rectangle {
  implicitHeight: 35
  color: Theme.dim
  radius: 10

  property string displayText

  TextInput {
    anchors.fill: parent
    anchors.leftMargin: parent.radius
    anchors.rightMargin: parent.radius
    color: Theme.fg
    selectionColor: Theme.accent
    selectedTextColor: Theme.bg
    verticalAlignment: TextInput.AlignVCenter
    focus: true
    text: parent.displayText

    font {
      family: "JetBrainsMono Nerd Font Mono"
      pixelSize: 14
    }
  }
}
