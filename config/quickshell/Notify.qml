import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Wayland

PanelWindow {
    id: rootWindow

    anchors {
        top: true
        bottom: true
        right: true
    }

    implicitWidth: 300
    implicitHeight: 100
    color: "transparent"

    WlrLayershell.layer: WlrLayershell.Overlay
    WlrLayershell.exclusiveZone: -1
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    ListView {
        id: notificationListView
        anchors.fill: parent
        spacing: 10
        model: notificationModel
        clip: true

        delegate: Item {
            id: notificationDelegate
            width: notificationListView.width
            height: 100

            Rectangle {
                id: notificationBox
                width: parent.width - 20
                height: 90
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 8
                color: "#1f1f28" // Kanagawa Dragon background
                opacity: 1
                border.color: "#7e9cd8" // Lotus blue
                border.width: 1

                Behavior on opacity {
                    PropertyAnimation {
                        duration: 300
                    }
                }

                Row {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Image {
                        source: model.appIcon
                        width: 32
                        height: 32
                        fillMode: Image.PreserveAspectFit
                    }

                    Column {
                        spacing: 4
                        width: parent.width - 60

                        Text {
                            text: model.appName
                            font.pixelSize: 20
                            font.bold: true
                            color: "#957fb8" // Fuji purple
                            elide: Text.ElideRight
                        }

                        Text {
                            text: model.summary
                            font.pixelSize: 16
                            color: "#dcd7ba" // Light text
                            wrapMode: Text.WordWrap
                        }

                        Text {
                            text: model.body
                            font.pixelSize: 18
                            color: "#7e9cd8" // Lotus blue
                            wrapMode: Text.WordWrap
                            visible: model.body.length > 0
                        }
                    }
                }

                Timer {
                    id: dismissTimer
                    interval: 3000
                    running: true
                    repeat: false
                    onTriggered: {
                        notificationBox.opacity = 0;
                    }
                }

                onOpacityChanged: {
                    if (opacity === 0) {
                        Qt.callLater(() => {
                            Qt.callLater(() => {
                                notificationServer.removeNotification(index);
                            });
                        });
                    }
                }
            }
        }

        remove: Transition {
            SequentialAnimation {
                PropertyAnimation {
                    properties: "y"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                PauseAnimation {
                    duration: 50
                }
            }
        }

        add: Transition {
            NumberAnimation {
                properties: "y"
                duration: 250
                easing.type: Easing.OutQuad
            }
        }
    }

    ListModel {
        id: notificationModel
    }

    NotificationServer {
        id: notificationServer
        actionsSupported: true
        bodyMarkupSupported: true
        imageSupported: true
        keepOnReload: false
        persistenceSupported: true

        onNotification: notification => {
            if (!notification.appName && !notification.summary && !notification.body) {
                if (typeof notification.dismiss === 'function') {
                    notification.dismiss();
                }
                return;
            }

            notificationModel.append({
                summary: notification.summary,
                appName: notification.appName,
                appIcon: notification.appIcon,
                body: notification.body
            });
        }

        function removeNotification(index) {
            if (index >= 0 && index < notificationModel.count) {
                notificationModel.remove(index);
            }
        }
    }
}
