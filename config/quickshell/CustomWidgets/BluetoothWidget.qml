import QtQuick
import Quickshell
import Quickshell.Bluetooth

InfoWidget {
    visible: Bluetooth.defaultAdapter?.devices?.values[0]?.state === 1
    iconSource: Quickshell.iconPath(Bluetooth.defaultAdapter?.devices?.values[0]?.icon ?? "")
    textColor: "#ff73ff"
    textContent: {
        const device = Bluetooth.defaultAdapter?.devices?.values[0];
        return device && typeof device.battery === "number" ? Math.round(device.battery * 100) + "%" : "";
    }
}
