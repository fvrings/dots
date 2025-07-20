import Quickshell
import Quickshell.Io // for Process
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Services.Notifications
import Quickshell.Wayland

PanelWindow {
    id: panel
    anchors {
        // top: true
        left: true
        right: true
    }

    margins {
        left: 300
        right: 300
    }
    focusable: true
    visible: false
    implicitHeight: 300
    color: "transparent"
    property string mode: "normal"
    aboveWindows: true
    WlrLayershell.layer: WlrLayer.Overlay
    exclusiveZone: 0 // Keep this to prevent window shrinking

    IpcHandler {
        target: "panel"
        function fire(): void {
            panel.visible = true;
        }
    }

    Rectangle {
        id: mainView
        anchors.fill: parent
        anchors.margins: 2
        color: "pink"
        focus: true
        // radius: 20
        bottomLeftRadius: 40
        topRightRadius: 40

        // visible: panel.mode === "normal"

        function dispatchKeys(key) {
            switch (key) {
            case "v":
                panel.mode = "volume";
                break;
            case "l":
                panel.mode = "light";
                break;
            case "q":
                panel.visible = false;
                break;
            }
        }

        Keys.onPressed: event => {
            dispatchKeys(event.text);
            event.accepted = true;
        }

        RowLayout {
            id: layout
            anchors.fill: parent // RowLayout now fills mainView
            spacing: 12 // Spacing between the buttons

            Rectangle {
                id: volumeButton
                Layout.preferredWidth: 200
                Layout.preferredHeight: 200
                // Layout.fillWidth: true // Allow this button to take up its share of width
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter // Center the button within its cell
                color: panel.mode == "volume" ? 'teal' : "#6effffff"
                radius: 20
                border.color: "#cccccc"
                border.width: 1
                antialiasing: true

                IconImage {
                    anchors.centerIn: parent
                    implicitSize: 30
                    source: Quickshell.iconPath("audio-volume-high-symbolic")
                }
            }
            Rectangle {
                id: lightButton
                Layout.preferredWidth: 200
                Layout.preferredHeight: 200
                // Layout.fillWidth: true // Allow this button to take up its share of width
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter // Center the button within its cell
                color: panel.mode == "light" ? 'teal' : "#6effffff"
                radius: 20
                border.color: "#cccccc"
                border.width: 1
                antialiasing: true

                IconImage {
                    anchors.centerIn: parent
                    implicitSize: 30
                    source: Quickshell.iconPath("preferences-system-brightness-lock")
                }
            }
        }
    }

    Loader {
        id: volumeLoader

        anchors.fill: parent
        anchors.margins: 2

        active: panel.mode === "volume"
        source: "Volume.qml"

        onLoaded: {
            item.forceActiveFocus();
            item.closeRequest.connect(function () {
                panel.mode = "normal";
                mainView.forceActiveFocus();
            });
        }
    }
    Loader {
        id: lightLoader

        anchors.fill: parent
        anchors.margins: 2

        active: panel.mode === "light"
        source: "Light.qml"

        onLoaded: {
            item.forceActiveFocus();
            item.closeRequest.connect(function () {
                panel.mode = "normal";
                mainView.forceActiveFocus();
            });
        }
    }
}
