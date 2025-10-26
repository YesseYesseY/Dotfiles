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
            property var baseRect: base

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
                    color: Hyprland.monitorFor(root.modelData).focused ? "#00FFFF" : "#595959"
                    width: 2

                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }
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

                WorkspacesWidget {
                    bar: root
                    anchors.centerIn: parent
                }

                Row {
                    spacing: 5

                    QuickMenu {
                        bar: root
                        barRect: base
                        textLeftPadding: 5
                    }

                    ClockWidget {
                        bar: root
                    }

                    SystemTrayWidget {
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

                    MemoryWidget {
                        bar: root
                        textRightPadding: 5
                    }

                    BatteryWidget {
                        bar: root
                    }
                }
            }
        }
    }
}
