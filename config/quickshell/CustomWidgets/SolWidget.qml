import QtQuick
import Quickshell
import Quickshell.Io

InfoWidget {
    id: root
    iconSource: Quickshell.iconPath("wallet-close")
    textColor: "pink"
    textContent: solText

    property string solText: "xx$"

    Process {
        id: solProc
        command: ["nu", "-c", "http get https://api.coingecko.com/api/v3/simple/price?ids=solana&vs_currencies=usd | get solana.usd"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.solText = this.text.trim()
        }
    }

    Timer {
        interval: 1000 * 60
        running: true
        repeat: true
        onTriggered: solProc.running = true
    }
}
