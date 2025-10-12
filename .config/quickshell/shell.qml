//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower
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
                id: base

                WorkspacesWidget {
                }

                ClockWidget {
                }

                Row {
                    height: parent.height
                    id: rightSideRow
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    layoutDirection: Qt.RightToLeft

                    MixerWidget {
                    }

                    BatteryWidget {
                    }

                    SystemTrayWidget {
                    }
                }
            }
        }
    }
}
