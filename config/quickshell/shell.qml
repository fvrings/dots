//@ pragma IconTheme BeautyLine
import Quickshell
import Quickshell.Io // for Process
import QtQuick
import QtQuick.Layouts
import Quickshell.Bluetooth
import Quickshell.Widgets

import "root:/Panel" as Panel

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
        implicitHeight: 26

        Rectangle {
            id: rt
            anchors.fill: parent
            anchors.margins: 2
            color: "transparent"

            radius: 20

            RowLayout {
                anchors.fill: parent

                Item {
                    visible: Bluetooth.defaultAdapter?.devices?.values[0]?.state === "Connected"
                    anchors.fill: parent

                    Row {
                        anchors.verticalCenter: parent.verticalCenter

                        IconImage {
                            implicitSize: 18
                            source: Quickshell.iconPath(Bluetooth.defaultAdapter?.devices?.values[0]?.icon ?? "")
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: {
                                const device = Bluetooth.defaultAdapter?.devices?.values[0];
                                return device && typeof device.battery === "number" ? Math.round(device.battery * 100) + "%" : "";
                            }
                            color: "red"
                            font.pointSize: 15
                            font.bold: true
                            font.family: "ComicShannsMono Nerd Font"
                            padding: 2
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Text {
                    id: clock
                    color: "pink"

                    font.pointSize: 14
                    font.family: "ComicShannsMono Nerd Font"
                    font.bold: true
                    padding: 2
                    Process {
                        // give the process object an id so we can talk
                        // about it from the timer
                        id: dateProc

                        command: ["date", '+%b %d  %H:%M']
                        running: true

                        stdout: StdioCollector {
                            onStreamFinished: clock.text = this.text
                        }
                    }

                    // use a timer to rerun the process at an interval
                    Timer {
                        // 1000 milliseconds is 1 second
                        interval: 1000 * 60

                        // start the timer immediately
                        running: true

                        // run the timer again when it ends
                        repeat: true

                        // when the timer is triggered, set the running property of the
                        // process to true, which reruns it if stopped.
                        onTriggered: dateProc.running = true
                    }
                }
            }
        }

        Panel.Main {}
        Osd {}

        Notify {
            id: notificationService
        }
    }
}
