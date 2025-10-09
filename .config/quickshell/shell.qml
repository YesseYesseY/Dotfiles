//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Controls

Scope {
    Variants {
        model: Quickshell.screens;
        PanelWindow {
            required property var modelData

            id: root
            screen: modelData
            implicitHeight: 40
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            Rectangle {
                color: "#FF121212"
                anchors.fill: parent
                // anchors.horizontalCenter: parent.horizontalCenter
                // anchors.bottom: parent.bottom
                // radius: 10
                // width: parent.width - 20
                // height: 30
                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    Repeater {
                        property var hyprlandMonitor: Hyprland.monitorFor(root.screen)
                        model: Hyprland.workspaces.values.filter(e => e.monitor.id == hyprlandMonitor.id)

                        Rectangle {
                            required property var modelData
                            property bool selected: modelData.id == Hyprland.focusedWorkspace.id

                            width: 30
                            height: 30
                            radius: 10

                            color: "transparent"

                            Text {
                                text: modelData.id
                                font.pixelSize: 22
                                anchors.centerIn: parent
                                color: selected ? "purple" : "white"
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
                    height: parent.height
                    id: rightSideRow
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    layoutDirection: Qt.RightToLeft

                    BarButton {
                        id: mixerButton
                        text: ""

                        LazyLoader {
                            active: Pipewire.ready && mixerButton.toggle

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

                    Repeater {
                        model: SystemTray.items

                        BarButton {
                            required property var modelData
                            source: modelData.icon
                            onClicked: sysTrayMenuAnchor.open()

                            QsMenuAnchor {
                                id: sysTrayMenuAnchor
                                menu: modelData.menu
                                anchor {
                                    item: parent
                                    edges: Edges.Top | Edges.Right
                                    gravity: Edges.Bottom | Edges.Left
                                    margins {
                                        top: 40
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
