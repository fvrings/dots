// MemWidget.qml
import QtQuick
import Quickshell
import Quickshell.Io

InfoWidget {
    id: root
    iconSource: Quickshell.iconPath("computer")
    textColor: "red"
    textContent: memText

    property string memText: "0%"

    Process {
        id: memProc
        command: ["nu", "-c", "sys mem | $in.used / $in.total * 100 | math round --precision 2 | into string | $in + '%'"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.memText = this.text.trim() + "%"
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: memProc.running = true
    }
}
