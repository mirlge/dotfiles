import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

RowLayout {
  StyledText {
    text: Qt.formatDateTime(ClockService.date, "yyyy-MM-dd")
  }

  StyledText {
    text: Qt.formatDateTime(ClockService.date, "hh:mm:ss")
  }
}
