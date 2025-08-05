// BatteryWidget.qml
import QtQuick
// import QtQuick.Layouts
// import Quickshell.Widgets
import Quickshell.Services.UPower
import Quickshell

InfoWidget {
    iconSource: Quickshell.iconPath("battery")
    textColor: "#91dc91"
    textContent: `${UPower.displayDevice.percentage * 100}%`
}
