pragma Singleton
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: tm

    property string currentTheme: "oxocarbon"
    readonly property var themes: ({
            "oxocarbon": "red",
            "vscode": "blue"
        })
    property string color: themes[currentTheme]

    property int notifCount: notifServer.trackedNotifications.values.length
    property ScriptModel notifications: serverNotifications
    property NotificationServer server: notifServer
    NotificationServer {
        id: notifServer

        actionIconsSupported: true
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: true
        bodySupported: true
        imageSupported: true
        persistenceSupported: true

        onNotification: n => n.tracked = true
    }

    ScriptModel {
        id: serverNotifications

        values: [...notifServer.trackedNotifications.values].reverse()
    }
}
