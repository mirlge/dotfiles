pragma Singleton
import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQml.Models

Singleton {
  property alias trackedNotifications: server.trackedNotifications
  property alias history: history

  NotificationServer {
    id: server
    actionsSupported: true
    bodySupported: true
    bodyMarkupSupported: true
    imageSupported: true
    onNotification: n => {
      history.insert(0, {
        notification: n,
        time: Qt.formatDateTime(new Date(), "HH:mm"),
        expired: false
      })

      n.tracked = true
    }
  }

  ListModel { id: history }
}
