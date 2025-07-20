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

    implicitWidth: 360
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
            implicitHeight: notificationBox.implicitHeight + 10

            Rectangle {
                id: notificationBox
                width: parent.width - 20
                color: "#1f1f28"
                border.color: "#7e9cd8"
                border.width: 1
                radius: 8

                anchors.horizontalCenter: parent.horizontalCenter

                implicitHeight: contentColumn.implicitHeight + 20

                Behavior on opacity {
                    PropertyAnimation {
                        duration: 300
                    }
                }

                Column {
                    id: contentColumn
                    spacing: 6
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: 10
                    }

                    Row {
                        spacing: 10

                        Image {
                            source: model.appIcon
                            width: 32
                            height: 32
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            text: model.appName
                            font.pixelSize: 20
                            font.bold: true
                            color: "#957fb8"
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Text {
                        text: model.summary
                        font.pixelSize: 16
                        color: "#dcd7ba"
                        wrapMode: Text.Wrap
                        width: parent.width - 20
                    }

                    Text {
                        text: model.body
                        font.pixelSize: 18
                        color: "#7e9cd8"
                        wrapMode: Text.Wrap
                        width: parent.width - 20
                        visible: model.body.length > 0
                    }
                }

                Timer {
                    id: dismissTimer
                    interval: 5000
                    running: true
                    repeat: false
                    onTriggered: {
                        notificationBox.opacity = 0;
                    }
                }

                onOpacityChanged: {
                    if (opacity === 0) {
                        Qt.callLater(() => notificationServer.removeNotification(index));
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
