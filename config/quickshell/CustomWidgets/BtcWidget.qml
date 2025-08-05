import QtQuick
import Quickshell
import Quickshell.Io

InfoWidget {
    id: root
    iconSource: Quickshell.iconPath("kwalletmanager")
    textColor: "#46ffff"
    textContent: btcText

    property string btcText: "xx$"

    Process {
        id: btcProc
        command: ["nu", "-c", "http get https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd | get bitcoin.usd"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.btcText = this.text.trim()
        }
    }

    Timer {
        interval: 1000 * 60
        running: true
        repeat: true
        onTriggered: btcProc.running = true
    }
}
