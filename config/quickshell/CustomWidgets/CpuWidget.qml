// CpuWidget.qml
import QtQuick
import Quickshell
import Quickshell.Io

InfoWidget {
    id: root
    iconSource: Quickshell.iconPath("cpu")
    textColor: "orange"
    textContent: cpuText

    property string cpuText: "0%"

    Process {
        id: cpuProc
        command: ["nu", "-c", "sys cpu -l | get cpu_usage | math avg | math round --precision 2"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.cpuText = this.text.trim() + "%"
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: cpuProc.running = true
    }
}
