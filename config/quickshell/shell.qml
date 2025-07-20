//@ pragma IconTheme BeautyLine
import Quickshell
import Quickshell.Io // for Process
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Notifications

import "root:/Panel" as Panel

Variants {
    model: Quickshell.screens
    PanelWindow {
        required property var modelData
        screen: modelData
        anchors {
            top: true
            left: true
            right: true
        }

        color: "transparent"
        implicitHeight: 26

        Rectangle {
            id: rt
            anchors.fill: parent
            anchors.margins: 2
            color: "transparent"

            radius: 20

            // Text {
            //     // text: Theme.notifCount
            //     text: Theme.notifications.values
            //     color: "red"
            //     // font.pixelSize: 18
            //     font.pointSize: 14
            //     font.bold: true
            //     font.family: "ComicShannsMono Nerd Font"
            //     leftPadding: 8
            // }

            RowLayout {
                anchors.fill: parent

                Text {
                    text: ""
                    color: "red"
                    // font.pixelSize: 18
                    font.pointSize: 15
                    font.bold: true
                    font.family: "ComicShannsMono Nerd Font"
                    // topPadding: 2
                    // leftPadding: 8
                    padding: 2
                    Layout.alignment: Qt.AlignTop
                }

                Item {
                    Layout.fillWidth: true
                }

                Text {
                    id: clock
                    color: "pink"

                    font.pointSize: 14
                    font.family: "ComicShannsMono Nerd Font"
                    font.bold: true
                    padding: 2
                    Process {
                        // give the process object an id so we can talk
                        // about it from the timer
                        id: dateProc

                        command: ["date", '+%b %d  %H:%M']
                        running: true

                        stdout: StdioCollector {
                            onStreamFinished: clock.text = this.text
                        }
                    }

                    // use a timer to rerun the process at an interval
                    Timer {
                        // 1000 milliseconds is 1 second
                        interval: 1000 * 60

                        // start the timer immediately
                        running: true

                        // run the timer again when it ends
                        repeat: true

                        // when the timer is triggered, set the running property of the
                        // process to true, which reruns it if stopped.
                        onTriggered: dateProc.running = true
                    }
                }
            }
        }

        Panel.Main {}
        Osd {}

        Notify {
            id: notificationService
        }
        // Rectangle {
        //     id: notificationPopup
        //     visible: (parent.modelData === (Quickshell.primaryScreen || Quickshell.screens[0])) && calculatedHeight > 20
        //     anchors {
        //         top: parent.top
        //         right: parent.right
        //         rightMargin: Data.Settings.borderWidth + 20
        //         topMargin: 0
        //     }
        //     width: 420
        //     height: 300
        //     // shell: desktop.shell
        //     // notificationServer: notificationService
        //     z: 15
        // }

        // Text {
        //     // give the text an ID we can refer to elsewhere in the file
        //     id: clock
        //
        //     anchors.centerIn: parent
        //
        //     // create a process management object
        //
        // }

        // Rectangle {
        //     id: rect
        //     width: 100
        //     //     anchors.centerIn: parent
        //     height: 100
        //     color: Theme.color
        //
        //     MouseArea {
        //         anchors.fill: parent
        //         onClicked: {
        //             Theme.currentTheme = "vscode";
        //         }
        //     }
        //     SequentialAnimation {
        //         running: true
        //         NumberAnimation {
        //             target: rect
        //             property: "x"
        //             to: 50
        //             duration: 1000
        //         }
        //         // NumberAnimation {
        //         //     target: rect
        //         //     property: "y"
        //         //     to: 50
        //         //     duration: 1000
        //         // }
        //     }
        // }

        // function parseNiriEvent(line) {
        //     try {
        //         // Handle workspace focus changes
        //         if (line.startsWith("Workspace focused: ")) {
        //             const workspaceId = parseInt(line.replace("Workspace focused: ", ""));
        //             if (!isNaN(workspaceId)) {
        //                 clock.text = workspaceId;
        //                 // const previousWorkspace = root.currentWorkspace;
        //                 // root.currentWorkspace = workspaceId;
        //                 // updateWorkspaceFocus(workspaceId);
        //
        //                 // Trigger burst effect if workspace actually changed
        //                 // if (previousWorkspace !== workspaceId && previousWorkspace !== -1) {
        //                 //     root.triggerUnifiedWave();
        //                 //     root.workspaceChanged(workspaceId, Data.ThemeManager.accent);
        //                 // }
        //             }
        //         } else
        //         // Handle workspace list updates
        //         if (line.startsWith("Workspaces changed: ")) {
        //             const workspaceData = line.replace("Workspaces changed: ", "");
        //             parseWorkspaceList(workspaceData);
        //         }
        //     } catch (e) {
        //         console.log("Error parsing niri event:", e);
        //     }
        // }
        //
        // function parseWorkspaceList(data) {
        //     try {
        //         const workspaceMatches = data.match(/Workspace \{[^}]+\}/g);
        //         if (!workspaceMatches) {
        //             return;
        //         }
        //
        //         const newWorkspaces = [];
        //
        //         for (const match of workspaceMatches) {
        //             const idMatch = match.match(/id: (\d+)/);
        //             const idxMatch = match.match(/idx: (\d+)/);
        //             const nameMatch = match.match(/name: Some\("([^"]+)"\)|name: None/);
        //             const outputMatch = match.match(/output: Some\("([^"]+)"\)/);
        //             const isActiveMatch = match.match(/is_active: (true|false)/);
        //             const isFocusedMatch = match.match(/is_focused: (true|false)/);
        //             const isUrgentMatch = match.match(/is_urgent: (true|false)/);
        //
        //             if (idMatch && idxMatch && outputMatch) {
        //                 const workspace = {
        //                     id: parseInt(idMatch[1]),
        //                     idx: parseInt(idxMatch[1]),
        //                     name: nameMatch && nameMatch[1] ? nameMatch[1] : "",
        //                     output: outputMatch[1],
        //                     isActive: isActiveMatch ? isActiveMatch[1] === "true" : false,
        //                     isFocused: isFocusedMatch ? isFocusedMatch[1] === "true" : false,
        //                     isUrgent: isUrgentMatch ? isUrgentMatch[1] === "true" : false
        //                 };
        //
        //                 newWorkspaces.push(workspace);
        //
        //                 if (workspace.isFocused) {
        //                     root.currentWorkspace = workspace.id;
        //                 }
        //             }
        //         }
        //
        //         // Sort by index and update model
        //         newWorkspaces.sort((a, b) => a.idx - b.idx);
        //         root.workspaces.clear();
        //         root.workspaces.append(newWorkspaces);
        //     } catch (e) {
        //         console.log("Error parsing workspace list:", e);
        //     }
        // }
    }
}
