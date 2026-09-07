pragma Singleton
import Quickshell
import QtQuick

Singleton {
  readonly property var date: clock.date

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
