//@ pragma IconTheme BeautyLine
import Quickshell
import Quickshell.Io // for Process
import QtQuick
import QtQuick.Layouts

import qs.Panel as Panel

import "CustomWidgets" as Widget

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

        Rectangle {
            id: rt
            anchors.fill: parent
            anchors.margins: 2
            color: "transparent"

            radius: 10

            // FileView {
            //     path: Qt.resolvedUrl("./tmp")
            //     watchChanges: true
            //     onFileChanged: {
            //         reload();
            //         let theme = this.text();
            //         console.log(`theme is ${theme}`);
            //         if (theme === "catppuccin-latte") {
            //             rt.color = "#234687";
            //         }
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
