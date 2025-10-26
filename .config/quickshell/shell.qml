//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens;
        PanelWindow {
            required property var modelData

            property var tooltip: tooltip

            id: root
            screen: modelData
            implicitHeight: 40
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            Tooltip {
                id: tooltip
                bar: root
            }

            Rectangle {
                color: "#FF121212"
                width: parent.width - 20
                height: 40
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                id: base

                border {
                    color: "#00FFFF"
                    width: 2
                }

                bottomLeftRadius: 10
                bottomRightRadius: 10

                Rectangle {
                    width: parent.width - 4
                    height: 2
                    color: "#FF121212"
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // Rectangle {
                //     width: parent.width
                //     height: 2
                //     color: "#00FFFF"
                //     anchors.bottom: parent.bottom
                // }

                WorkspacesWidget {
                    bar: root
                    anchors.centerIn: parent
                }

                Row {
                    QuickMenu {
                        bar: root
                        barRect: base
                    }

                    ClockWidget {
                        bar: root
                    }
                }

                Row {
                    height: parent.height
                    id: rightSideRow
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    layoutDirection: Qt.RightToLeft
                    spacing: 5

                    BarButton {
                        bar: root
                        text: "\udb81\udd7e"
                        onClicked: pavu.running = true

                        Process {
                            id: pavu
                            command: ["pavucontrol"]
                        }
                    }

                    MusicPlayer {
                        bar: root
                    }

                    BatteryWidget {
                        bar: root
                    }

                    MemoryWidget {
                        bar: root
                    }

                    SystemTrayWidget {
                        bar: root
                    }
                }
            }
        }
    }
}
