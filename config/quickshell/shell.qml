//@ pragma IconTheme BeautyLine
import Quickshell
import Quickshell.Io // for Process
import QtQuick
import QtQuick.Layouts

import qs.Panel as Panel

import qs.CustomWidgets as Widget

Variants {
    model: Quickshell.screens
    PanelWindow {
        required property var modelData
        screen: modelData
        anchors {
            top: true
            left: true
            right: true
        }

        color: "transparent"
        implicitHeight: 36

        Loader {
            id: themeLoader
            source: "/etc/theme-config.qml"
        }

        IpcHandler {
            target: "themeLoader"
            function reloadTheme(): void {
                // HACK: https://forum.qt.io/post/606555
                themeLoader.source = "/etc/theme-config.qml?" + Math.random();
            }
        }

        Rectangle {
            id: rt
            anchors.fill: parent
            anchors.margins: 2
            color: themeLoader.item.backgroundColor
            // Component.onCompleted: {
            //     console.log("theme");
            //     console.log(themeLoader.item.backgroundColor);
            // }

            radius: 10

            // FileView {
            //     path: Qt.resolvedUrl("/etc/specialisation")
            //     watchChanges: true
            //     onFileChanged: {
            //         reload();
            //         let theme = this.text();
            //         console.log(`theme is ${theme}`);
            //         if (theme.trim() === "catppuccin-latte") {
            //             rt.color = "#234687";
            //         }
            //     }
            //     onSaved: {
            //         console.log("onsaved");
            //     }
            //     onLoaded: {
            //         console.log("onloaded");
            //     }
            // }

            RowLayout {
                anchors.fill: parent
                anchors.topMargin: 3
                anchors.bottomMargin: 3
                anchors.margins: 10

                Widget.BatteryWidget {}

                Widget.MemWidget {}

                Widget.CpuWidget {}

                Widget.NetWidget {}

                Item {
                    Layout.fillWidth: true
                }

                Widget.BluetoothWidget {}

                Widget.BtcWidget {}
                Widget.SolWidget {}

                Widget.NixosWidget {}

                Widget.ClockWidget {}
            }
        }

        Panel.Main {}
        Osd {}

        Notify {
            id: notificationService
        }
    }
}
