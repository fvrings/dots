import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets

Item {
    id: volumeRoot
    focus: true

    signal closeRequest

    Process {
        id: hprocess
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "10%-"]
    }
    Process {
        id: jprocess
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "1%-"]
    }
    Process {
        id: kprocess
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "1%+"]
    }
    Process {
        id: lprocess
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "10%+"]
    }
    Process {
        id: mprocess
        command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]
    }
    function dispatchKeys(key) {
        switch (key) {
        case "h":
            hprocess.running = true;
            break;
        case "j":
            jprocess.running = true;
            break;
        case "k":
            kprocess.running = true;
            break;
        case "l":
            lprocess.running = true;
            break;
        case "m":
            mprocess.running = true;
            break;
        case "q":
            closeRequest();
            break;
        }
    }

    Keys.onPressed: event => {
        dispatchKeys(event.text);
        event.accepted = true;
    }
    Component.onCompleted: {
        volumeRoot.forceActiveFocus();
    }
}
