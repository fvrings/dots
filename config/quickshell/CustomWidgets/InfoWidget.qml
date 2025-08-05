// InfoWidget.qml
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

RowLayout {
    property alias iconSource: icon.source
    property alias textContent: textItem.text
    property alias textColor: textItem.color

    IconImage {
        id: icon
        implicitWidth: 14
        implicitHeight: 14
        Layout.topMargin: 4
        Layout.alignment: Qt.AlignTop
    }

    Text {
        id: textItem
        font.pointSize: 13
        font.bold: true
        font.family: "Comic Mono"
        padding: 2
        Layout.alignment: Qt.AlignBaseline
    }
}
