import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls

Scope {
    Variants {
        model: Quickshell.screens;
        PanelWindow {
            required property var modelData
            property var hyprlandMonitor: Hyprland.monitorFor(root.screen)

            id: root
            screen: modelData
            implicitHeight: 30

            color: "#8F666666"
            anchors {
                top: true
                left: true
                right: true
            }
    
            Row {
                Repeater {

                    model: Hyprland.workspaces.values.filter(e => e.monitor.id == root.hyprlandMonitor.id)

                    Rectangle {
                        required property var modelData

                        width: 30
                        height: 30
                        border.width: 2
                        border.color: "black"

                        color: modelData.id == Hyprland.focusedWorkspace.id ? "#FFFFFFFF" : "transparent"

                        Text {
                            text: modelData.id
                            font.pixelSize: 22
                            anchors.centerIn: parent
                        }
                    }
                }
            }

            ClockWidget {
                color: "#EEEEEE"
                anchors.centerIn: parent
                font.pixelSize: 22
            }

            Row {
                anchors.right: parent.right

                Rectangle {
                    id: mixerRect
                    property bool windowActive: false

                    width: root.implicitHeight
                    height: root.implicitHeight

                    MouseArea {
                        anchors.fill: parent
                        onClicked: (mouse) => {
                            parent.windowActive = !parent.windowActive
                        }
                    }
                    Text {
                        anchors.centerIn: parent
                        text: ""

                    }
                    LazyLoader {
                        active: Pipewire.ready && mixerRect.windowActive

                        PopupWindow {
                            id: mixerWindow
                            anchor.window: root
                            anchor.rect.x: parentWindow.width
                            anchor.rect.y: parentWindow.height + 5
                            implicitWidth: 750
                            implicitHeight: 750
                            visible: true


                            PwNodeLinkTracker {
                                id: nodeLinkTracker
                                node: Pipewire.defaultAudioSink
                            }

                            PwObjectTracker {
                                objects: Pipewire.defaultAudioSink
                            }

                            Column {
                                id: mixerEntries
                                property var pipenodes: nodeLinkTracker.linkGroups.map(e => e.source) 

                                PwObjectTracker {
                                    objects: mixerEntries.pipenodes
                                }

                                MixerEntry {
                                    node: Pipewire.defaultAudioSink
                                }

                                Repeater {
                                    model: mixerEntries.pipenodes

                                    MixerEntry {
                                        required property var modelData
                                        node: modelData
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
