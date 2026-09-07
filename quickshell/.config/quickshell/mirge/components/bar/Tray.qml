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
      //onClicked: modelData.display(bar, x, y)
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

      WrapperRectangle {
        color: root.containsMouse ? (root.modelData.status === Status.NeedsAttention ? Theme.yellow : Theme.dim) : "transparent"
        implicitHeight: bar.implicitHeight

        IconImage {
          anchors.centerIn: parent
          source: root.modelData.icon
          implicitSize: bar.implicitHeight * 0.6
        }
      }

      QsMenuAnchor {
        id: menu
        anchor {
          window: bar
          item: root
        }
        menu: root.modelData.menu
      }

      Tooltip {
        anchor {
          window: bar
          item: root
        }
        hovered: root.containsMouse

        ColumnLayout {
          StyledText {
            color: Theme.accent
            text: root.modelData.tooltipTitle || root.modelData.title
            visible: text !== ""
            font.bold: true
          }

          StyledText {
            text: root.modelData.tooltipDescription || ""
            visible: text !== ""
          }
        }
      }
    }
  }
}
