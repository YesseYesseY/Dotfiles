import QtQuick
import QtQuick.Controls
import Quickshell.Services.Mpris

BarButton {
    id: root
    text: "\udb81\udf5a"
    visible: Mpris.players.values.length > 0
    tooltipItem: Column {
        id: toolRoot
        width: 400
        height: 450
        padding: 10
        spacing: 10
        property int mprisIndex: 0
        property var mprisCurrent: Mpris.players.values[mprisIndex]

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5

            BetterButton {
                text: "\uf104"
                textSize: 20
                height: 35
                onClicked: {
                    if (root.tooltipItem.mprisIndex == 0) root.tooltipItem.mprisIndex = Mpris.players.values.length - 1;
                    else root.tooltipItem.mprisIndex--;
                    posTimer.restart();
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.tooltipItem.mprisCurrent.identity
                color: "white"
                font.pixelSize: 20
            }

            BetterButton {
                text: "\uf105"
                textSize: 20
                height: 35
                onClicked: {
                    if (root.tooltipItem.mprisIndex == Mpris.players.values.length - 1) root.tooltipItem.mprisIndex = 0;
                    else root.tooltipItem.mprisIndex++;
                    posTimer.restart();
                }
            }
        }
        
        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: parent.mprisCurrent.trackArtUrl
            width: 250
            height: 250
            fillMode: Image.PreserveAspectFit
        }

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 350
                elide: Text.ElideRight
                text: root.tooltipItem.mprisCurrent.trackTitle
                color: "white"
                font.pixelSize: 17
                // NumberAnimation on leftPadding { from: 0; to: 100; duration: 2000; }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: root.tooltipItem.mprisCurrent.trackArtist
                color: "white"
                font.pixelSize: 15
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: Time.stringifySeconds(posTimer.lastUpdate);
                color: "white"
                font.pixelSize: 15
                rightPadding: 5
            }

            Slider {
                anchors.verticalCenter: parent.verticalCenter
                width: 250
                onMoved: {
                    root.tooltipItem.mprisCurrent.position = root.tooltipItem.mprisCurrent.length * value
                }

                Timer {
                    id: posTimer
                    property var lastUpdate: 0
                    running: root.tooltipItem.mprisCurrent.isPlaying
                    interval: 1000
                    repeat: true
                    triggeredOnStart: true
                    onTriggered: {
                        lastUpdate = root.tooltipItem.mprisCurrent.position 
                        parent.value = lastUpdate / root.tooltipItem.mprisCurrent.length
                    }
                }
            }

            Text {
                leftPadding: 5
                anchors.verticalCenter: parent.verticalCenter
                text: Time.stringifySeconds(toolRoot.mprisCurrent.length);
                color: "white"
                font.pixelSize: 15
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            Rectangle {
                width: 40
                height: 40
                radius: 50
                visible: toolRoot.mprisCurrent.loopSupported
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        let newState = null;
                        switch (toolRoot.mprisCurrent.loopState) {
                            case MprisLoopState.None: newState = MprisLoopState.Playlist; break;
                            case MprisLoopState.Playlist: newState = MprisLoopState.Track; break;
                            case MprisLoopState.Track: newState = MprisLoopState.None; break;
                         }
                        console.log(newState);
                        toolRoot.mprisCurrent.loopState = newState;
                    }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: {
                        switch (toolRoot.mprisCurrent.loopState) {
                            case MprisLoopState.None: return "\udb81\udc57";
                            case MprisLoopState.Playlist: return "\udb81\udc56";
                            case MprisLoopState.Track: return "\udb81\udc58";
                        }
                    }
                    font.pixelSize: 30
                }
            }
            Rectangle {
                width: 40
                height: 40
                radius: 50
                visible: toolRoot.mprisCurrent.canGoPrevious
                MouseArea {
                    anchors.fill: parent
                    onClicked: toolRoot.mprisCurrent.previous();
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "\udb81\udcae"
                    font.pixelSize: 30
                }
            }
            Rectangle {
                width: 40
                height: 40
                radius: 50
                visible: toolRoot.mprisCurrent.canTogglePlaying
                MouseArea {
                    anchors.fill: parent
                    onClicked: toolRoot.mprisCurrent.togglePlaying();
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: toolRoot.mprisCurrent.isPlaying ? "\udb80\udfe4" : "\udb81\udc0a"
                    font.pixelSize: 30
                }
            }
            Rectangle {
                width: 40
                height: 40
                radius: 50
                visible: toolRoot.mprisCurrent.canGoNext
                MouseArea {
                    anchors.fill: parent
                    onClicked: toolRoot.mprisCurrent.next();
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: "\udb81\udcad"
                    font.pixelSize: 30
                }
            }
            Rectangle {
                width: 40
                height: 40
                radius: 50
                visible: toolRoot.mprisCurrent.shuffleSupported
                MouseArea {
                    anchors.fill: parent
                    onClicked: toolRoot.mprisCurrent.shuffle = !toolRoot.mprisCurrent.shuffle;
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: toolRoot.mprisCurrent.shuffle ? "\udb81\udc9f" : "\udb81\udc9e"
                    font.pixelSize: 30
                }
            }
        }
    }
}
