import QtQuick
import Quickshell
import Quickshell.Io

InfoWidget {
    id: root
    visible: false
    iconSource: Quickshell.iconPath("nixos")
    textColor: "black"
    textContent: ""

    Process {
        id: nixProc
        command: ["nu", "-c", 'http get "https://prometheus.nixos.org/api/v1/query?query=channel_update_time" | get data.result.0.value.1 | into int | into datetime -f "%s" | ($in | format date "%Y-%m-%d") == (date now | format date "%Y-%m-%d")']
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                let update_today = this.text.trim();
                if (update_today == "true") {
                    root.visible = true;
                } else {
                    root.visible = false;
                }
            }
        }
    }

    Timer {
        interval: 1000 * 60 * 60 * 4
        running: true
        repeat: true
        onTriggered: nixProc.running = true
    }
}
