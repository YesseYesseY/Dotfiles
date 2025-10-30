// Idk what else to call it if not QuickMenu lol

import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Mpris

BarButton {
    required property var barRect

    id: root
    width: height
    text: "\uf359"
    bottomLeftRadius: 10
    onClicked: menuWindow.toggleOpen();
    textColor: "#00FFFF"

    PopupWindow {
        id: menuWindow
        anchor {
            item: root
            rect {
                y: root.bar.height - 2
            }
        }
        implicitWidth: menuContent.width ?? 1
        implicitHeight: menuContent.height ?? 1
        color: "transparent"

        property bool open: false

        function toggleOpen() {
            if (!open) {
                menuRect.height = menuContent.height;
                barRect.bottomLeftRadius = 0;
                bottomLeftRadius = 0;
                menuWindow.visible = true;
            } else {
                menuRect.height = 0;
            }
            open = !open
        }
        
        Rectangle {
            id: menuRect
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: 0
            color: "#FF121212"
            radius: 10
            topLeftRadius: 0
            topRightRadius: 0
            border {
                color: root.barRect.border.color
                width: 2
            }

            Behavior on height {
                NumberAnimation {
                    duration: 100
                    onRunningChanged: {
                        if (!running) {
                            if (menuRect.height === 0) {
                                menuWindow.visible = false;
                                barRect.bottomLeftRadius = 10;
                                root.bottomLeftRadius = 10;
                            }
                        }
                    }
                }
            }

            Rectangle {
                color: parent.color
                width: parent.width - 4
                height: 2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                visible: parent.height > 0
            }

            Column {
                id: menuContent
                padding: 10
                spacing: 10

                Row {
                    spacing: 10
                    BetterButton {
                        text: "\udb81\udd7e"
                        onClicked: pavu.running = true
                        height: 50
                        width: height
                        radius: 10
                        border {
                            color: "white"
                            width: 2
                        }

                        Process {
                            id: pavu
                            command: ["pavucontrol"] // TODO not depend on pavucontrol
                        }
                    }

                    BetterButton {
                        text: "\udb80\udcaf"
                        onClicked: bluetooth.running = true
                        height: 50
                        width: height
                        radius: 10
                        border {
                            color: "white"
                            width: 2
                        }

                        Process {
                            id: bluetooth
                            command: ["notify-send", "Quickshell",  "Sorry i haven't implemented bluetooth yet :("]
                        }
                    }
                }


            }
        }
    }
}
