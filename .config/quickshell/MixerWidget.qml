import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls

BarButton {
    id: mixerButton
    text: ""

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

            PwNodeLinkTracker {
                id: nodeLinkTracker
                node: Pipewire.defaultAudioSink
            }

            PwObjectTracker {
                objects: Pipewire.defaultAudioSink
            }

            Rectangle {
                anchors.fill: parent
                radius: 10
                color: "#FF121212"

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
