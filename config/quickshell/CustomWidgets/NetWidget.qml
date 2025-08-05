// NetWidget.qml
import QtQuick
import Quickshell
import Quickshell.Io

InfoWidget {
    id: root
    iconSource: Quickshell.iconPath("io.elementary.monitor")
    textColor: "#87e1f8"
    textContent: netText

    property string netText: ""

    Process {
        id: netProc
        command: ["sh", "-c", "interface=$(ip route | grep default | awk '{print $5}' | head -1); if [ -n \"$interface\" ]; then rx1=$(cat /sys/class/net/$interface/statistics/rx_bytes); tx1=$(cat /sys/class/net/$interface/statistics/tx_bytes); sleep 1; rx2=$(cat /sys/class/net/$interface/statistics/rx_bytes); tx2=$(cat /sys/class/net/$interface/statistics/tx_bytes); rx_rate=$((rx2-rx1)); tx_rate=$((tx2-tx1)); if [ $rx_rate -gt 1048576 ]; then rx_display=$(echo \"scale=1; $rx_rate/1048576\" | bc)MB/s; elif [ $rx_rate -gt 1024 ]; then rx_display=$(echo \"$rx_rate/1024\" | bc)KB/s; else rx_display=${rx_rate}B/s; fi; if [ $tx_rate -gt 1048576 ]; then tx_display=$(echo \"scale=1; $tx_rate/1048576\" | bc)MB/s; elif [ $tx_rate -gt 1024 ]; then tx_display=$(echo \"$tx_rate/1024\" | bc)KB/s; else tx_display=${tx_rate}B/s; fi; echo \"↓$rx_display ↑$tx_display\"; else echo \"No Net\"; fi"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.netText = this.text.trim()
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: netProc.running = true
    }
}
