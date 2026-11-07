import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

RowLayout {
  spacing: 7

  Repeater {
    model: SystemTray.items

    WrapperMouseArea {
      id: root
      acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
      onClicked: (mouse) => {
        if (mouse.button === Qt.LeftButton) {
          if (modelData.onlyMenu) menu.open()
          else modelData.activate()
        }
        else if (mouse.button === Qt.RightButton) menu.open()
        else if (mouse.button === Qt.MiddleButton) modelData.secondaryActivate()
        mouse.accepted = true
      }
      onWheel: modelData.scroll(1, false)
      hoverEnabled: true

      required property SystemTrayItem modelData
      readonly property var status: modelData.status
      readonly property var menu: modelData.menu

      readonly property string iconPath: modelData.icon
      readonly property string tooltipTitle: modelData.tooltipTitle
      readonly property string title: modelData.title
      readonly property string tooltipDescription: modelData.tooltipDescription

      WrapperRectangle {
        color: root.containsMouse ? Theme.dim : (root.status === Status.NeedsAttention ? Theme.yellow : "transparent")
        implicitHeight: bar.implicitHeight

        IconImage {
          anchors.centerIn: parent
          source: root.iconPath
          implicitSize: bar.implicitHeight * 0.6
        }
      }

      QsMenuAnchor {
        id: menu
        anchor {
          window: bar
          item: root
          margins.top: bar.implicitHeight
        }
        menu: root.menu
      }

      Tooltip {
        anchor {
          window: bar
          item: root
          margins.top: bar.implicitHeight
        }
        hovered: root.containsMouse

        ColumnLayout {
          StyledText {
            color: Theme.accent
            text: root.tooltipTitle || root.title
            visible: text !== ""
            font.bold: true
          }

          StyledText {
            text: root.tooltipDescription || ""
            visible: text !== ""
          }
        }
      }
    }
  }
}
