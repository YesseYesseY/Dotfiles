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
    visible: currentPlayer !== undefined

    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        spacing: 5
        Image {
            id: mpImage
            height: mpBase.height - 20
            width: height
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
                        radius: 5
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
                    width: mpBase.width - mpImage.width - 150
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
