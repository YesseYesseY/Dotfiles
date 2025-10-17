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
                width: parent.width
                height: 40
                anchors.top: parent.top
                id: base

                WorkspacesWidget {
                    bar: root
                }

                ClockWidget {
                    bar: root
                }

                Row {
                    height: parent.height
                    id: rightSideRow
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    layoutDirection: Qt.RightToLeft

                    MixerWidget {
                        bar: root
                    }

                    BatteryWidget {
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
