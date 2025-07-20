import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets

Item {
    id: lightRoot
    focus: true

    signal closeRequest

    Process {
        id: hprocess
        command: ["brightnessctl", "set", "10%-"]
        onExited: {
            console.log(exitCode);
            console.log("exited");
        }
        onStarted: {
            console.log("start");
        }
    }
    Process {
        id: jprocess
        command: ["brightnessctl", "set", "1%-"]
    }
    Process {
        id: kprocess
        command: ["brightnessctl", "set", "1%+"]
    }
    Process {
        id: lprocess
        command: ["brightnessctl", "set", "10%+"]
    }
    function dispatchKeys(key) {
        console.log(key);
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
        lightRoot.forceActiveFocus();
    }
}
