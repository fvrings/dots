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
        // color: "gray"
        implicitHeight: 36

        Rectangle {
            id: rt
            anchors.fill: parent
            anchors.margins: 2
            color: "transparent"

            radius: 20

            RowLayout {
                anchors.fill: parent
                anchors.topMargin: 3
                anchors.bottomMargin: 3

                // Memory Widget
                IconImage {
                    implicitWidth: 14
                    implicitHeight: 14
                    source: Quickshell.iconPath("computer")
                    Layout.topMargin: 6
                    Layout.alignment: Qt.AlignTop
                }

                Text {
                    id: mem
                    color: "red"
                    font.pointSize: 14
                    font.bold: true
                    font.family: "Comic Mono"
                    padding: 2
                    Layout.alignment: Qt.AlignBaseline

                    Process {
                        id: memProc
                        command: ["nu", "-c", "sys mem | $in.used / $in.total * 100 | math round --precision 2 | into string | $in + '%'"]
                        running: true

                        stdout: StdioCollector {
                            onStreamFinished: {
                                mem.text = this.text;
                            }
                        }
                    }

                    Timer {
                        interval: 5000
                        running: true
                        repeat: true
                        onTriggered: memProc.running = true
                    }
                }

                // CPU Widget
                IconImage {
                    implicitWidth: 14
                    implicitHeight: 14
                    source: Quickshell.iconPath("cpu")
                    Layout.topMargin: 6
                    Layout.alignment: Qt.AlignTop
                }

                Text {
                    id: cpu
                    color: "orange"
                    font.pointSize: 14
                    font.bold: true
                    font.family: "Comic Mono"
                    padding: 2
                    Layout.alignment: Qt.AlignBaseline

                    Process {
                        id: cpuProc
                        command: ["sh", "-c", "cat /proc/loadavg | cut -d' ' -f1"]
                        running: true

                        stdout: StdioCollector {
                            onStreamFinished: {
                                cpu.text = this.text.trim() + "%";
                            }
                        }
                    }

                    Timer {
                        interval: 2000
                        running: true
                        repeat: true
                        onTriggered: cpuProc.running = true
                    }
                }

                // Network I/O Widget
                IconImage {
                    implicitWidth: 16
                    implicitHeight: 16
                    source: Quickshell.iconPath("network-wireless")
                    Layout.topMargin: 6
                    Layout.alignment: Qt.AlignTop
                }

                Text {
                    id: network
                    color: "pink"
                    font.pointSize: 13
                    font.bold: true
                    font.family: "Comic Mono"
                    padding: 2
                    Layout.alignment: Qt.AlignBaseline

                    Process {
                        id: networkProc
                        command: ["sh", "-c", "interface=$(ip route | grep default | awk '{print $5}' | head -1); if [ -n \"$interface\" ]; then rx1=$(cat /sys/class/net/$interface/statistics/rx_bytes); tx1=$(cat /sys/class/net/$interface/statistics/tx_bytes); sleep 1; rx2=$(cat /sys/class/net/$interface/statistics/rx_bytes); tx2=$(cat /sys/class/net/$interface/statistics/tx_bytes); rx_rate=$((rx2-rx1)); tx_rate=$((tx2-tx1)); if [ $rx_rate -gt 1048576 ]; then rx_display=$(echo \"scale=1; $rx_rate/1048576\" | bc)MB/s; elif [ $rx_rate -gt 1024 ]; then rx_display=$(echo \"$rx_rate/1024\" | bc)KB/s; else rx_display=${rx_rate}B/s; fi; if [ $tx_rate -gt 1048576 ]; then tx_display=$(echo \"scale=1; $tx_rate/1048576\" | bc)MB/s; elif [ $tx_rate -gt 1024 ]; then tx_display=$(echo \"$tx_rate/1024\" | bc)KB/s; else tx_display=${tx_rate}B/s; fi; echo \"↓$rx_display ↑$tx_display\"; else echo \"No Net\"; fi"]
                        running: true

                        stdout: StdioCollector {
                            onStreamFinished: {
                                network.text = this.text.trim();
                            }
                        }
                    }

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: networkProc.running = true
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                // Bluetooth Widget (flattened)
                IconImage {
                    visible: Bluetooth.defaultAdapter?.devices?.values[0]?.state === 1
                    implicitWidth: 15
                    implicitHeight: 15
                    source: Quickshell.iconPath(Bluetooth.defaultAdapter?.devices?.values[0]?.icon ?? "")
                    Layout.topMargin: 6
                    Layout.alignment: Qt.AlignTop
                }

                Text {
                    visible: Bluetooth.defaultAdapter?.devices?.values[0]?.state === 1
                    text: {
                        const device = Bluetooth.defaultAdapter?.devices?.values[0];
                        return device && typeof device.battery === "number" ? Math.round(device.battery * 100) + "%" : "";
                    }
                    color: "cyan"
                    font.pointSize: 12
                    font.bold: true
                    font.family: "Comic Mono"
                    padding: 2
                    Layout.alignment: Qt.AlignBaseline
                }
                IconImage {
                    implicitWidth: 14
                    implicitHeight: 14
                    source: Quickshell.iconPath("deepin-calendar")
                    Layout.topMargin: 6
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    id: clock
                    color: "#f050d2"
                    font.pointSize: 13
                    font.family: "Comic Mono"
                    font.bold: true
                    padding: 2
                    Layout.alignment: Qt.AlignBaseline

                    Process {
                        id: dateProc
                        command: ["date", '+%b %d  %H:%M']
                        running: true

                        stdout: StdioCollector {
                            onStreamFinished: clock.text = this.text
                        }
                    }

                    Timer {
                        interval: 1000 * 60
                        running: true
                        repeat: true
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
