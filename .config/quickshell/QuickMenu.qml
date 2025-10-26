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
                menuRect.height = menuWindow.height;
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

                Rectangle {
                    id: mpBase
                    width: 400
                    height: 150
                    radius: 10
                    color: "transparent"
                    border {
                        color: "white"
                        width: 2
                    }

                    property var currentPlayer: Mpris.players.values[0]

                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        spacing: 5
                        Rectangle {
                            height: mpBase.height - 20
                            width: height
                            color: "white"
                            radius: 10

                            Image {
                                id: mpImage
                                width: parent.width - 4
                                height: parent.height - 4
                                anchors.centerIn: parent
                                source: mpBase.currentPlayer.trackArtUrl

                                // https://stackoverflow.com/questions/6090740/image-rounded-corners-in-qml
                                layer.enabled: true
                                layer.effect: OpacityMask {
                                    maskSource: Item {
                                        width: mpImage.width
                                        height: mpImage.height
                                        Rectangle {
                                            anchors.centerIn: parent
                                            width: parent.width
                                            height: parent.height
                                            radius: 10
                                        }
                                    }
                                }

                            }
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            rightPadding: 10
                            width: mpBase.width - 30 - mpImage.width
                            Text {
                                text: mpBase.currentPlayer.trackTitle
                                width: parent.width
                                elide: Text.ElideRight
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 15
                                color: "white"
                            }
                            Text {
                                text: mpBase.currentPlayer.trackArtist
                                width: parent.width
                                elide: Text.ElideRight
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 15
                                color: "white"
                            }

                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 5
                                topPadding: 5
                                Timer {
                                    id: posTimer
                                    property var pos: 0
                                    running: menuWindow.open
                                    repeat: true
                                    triggeredOnStart: true
                                    onTriggered: {
                                        pos = mpBase.currentPlayer.position;
                                        mpProgress.value = pos / mpBase.currentPlayer.length;
                                    }
                                }
                                Text {
                                    text: Time.stringifySeconds(posTimer.pos);
                                    color: "white"
                                }
                                Slider {
                                    id: mpProgress
                                    onMoved: {
                                        mpBase.currentPlayer.position = mpBase.currentPlayer.length * value;
                                        posTimer.restart();
                                    }
                                }
                                Text {
                                    text: Time.stringifySeconds(mpBase.currentPlayer.length);
                                    color: "white"
                                }
                            }
                            
                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 10
                                topPadding: 5
                                BetterButton {
                                    visible: mpBase.currentPlayer.loopSupported
                                    text: {
                                        switch (mpBase.currentPlayer.loopState) {
                                            case MprisLoopState.None: return "\udb81\udc57";
                                            case MprisLoopState.Playlist: return "\udb81\udc56";
                                            case MprisLoopState.Track: return "\udb81\udc58";
                                        }
                                    }
                                    textSize: 20
                                    radius: 10
                                    border {
                                        color: "white"
                                        width: 2
                                    }
                                    onClicked: {
                                        let newState = null;
                                        switch (mpBase.currentPlayer.loopState) {
                                            case MprisLoopState.None: newState = MprisLoopState.Playlist; break;
                                            case MprisLoopState.Playlist: newState = MprisLoopState.Track; break;
                                            case MprisLoopState.Track: newState = MprisLoopState.None; break;
                                        }
                                        mpBase.currentPlayer.loopState = newState;
                                    }
                                }
                                BetterButton {
                                    visible: mpBase.currentPlayer.canGoPrevious
                                    text: "\udb81\udcae"
                                    textSize: 20
                                    radius: 10
                                    border {
                                        color: "white"
                                        width: 2
                                    }
                                    onClicked: mpBase.currentPlayer.previous();
                                }
                                BetterButton {
                                    visible: mpBase.currentPlayer.canTogglePlaying
                                    text: mpBase.currentPlayer.isPlaying ? "\udb80\udfe4" : "\udb81\udc0a"
                                    textSize: 20
                                    radius: 10
                                    border {
                                        color: "white"
                                        width: 2
                                    }
                                    onClicked: mpBase.currentPlayer.togglePlaying();
                                }
                                BetterButton {
                                    visible: mpBase.currentPlayer.canGoNext
                                    text: "\udb81\udcad"
                                    textSize: 20
                                    radius: 10
                                    border {
                                        color: "white"
                                        width: 2
                                    }
                                    onClicked: mpBase.currentPlayer.next();
                                }
                                BetterButton {
                                    visible: mpBase.currentPlayer.shuffleSupported
                                    text: mpBase.currentPlayer.shuffle ? "\udb81\udc9f" : "\udb81\udc9e"
                                    textSize: 20
                                    radius: 10
                                    border {
                                        color: "white"
                                        width: 2
                                    }
                                    onClicked: mpBase.currentPlayer.shuffle = !mpBase.currentPlayer.shuffle;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
