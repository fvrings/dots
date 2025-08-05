import QtQuick
import Quickshell

InfoWidget {
    iconSource: Quickshell.iconPath("deepin-calendar")
    textColor: "#f050d2"
    textContent: Qt.formatDateTime(clock.date, "ddd MMM d hh:mm")
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
