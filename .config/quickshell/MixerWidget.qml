import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls

BarButton {
    id: mixerButton
    text: {
        const volume = Pipewire.defaultAudioSink.audio.volume * 100
        
        if (Pipewire.defaultAudioSink.audio.muted) return "\udb81\udd81"

        if (volume <= 33) return "\udb81\udd7f"
        else if (volume >= 67) return "\udb81\udd7e"
        else return "\udb81\udd80"
    }

    PwNodeLinkTracker {
        id: nodeLinkTracker
        node: Pipewire.defaultAudioSink
    }

    PwObjectTracker {
        objects: Pipewire.defaultAudioSink
    }

    LazyLoader {
        active: Pipewire.ready && mixerButton.toggle

        PopupWindow {
            id: mixerWindow
            implicitWidth: 750
            implicitHeight: 500
            visible: true
            color: "transparent"
            anchor {
                item: mixerButton
                rect {
                    y: parentWindow.height + 5
                }
            }

            Rectangle {
                anchors.fill: parent
                radius: 10
                color: "#FF121212"

                Behavior on height { NumberAnimation { duration: 200 } }

                Column {
                    id: mixerEntries
                    topPadding: 10
                    leftPadding: 10

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
