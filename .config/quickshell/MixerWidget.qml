import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick

BarButton {
    id: mixerButton
    text: ""

    LazyLoader {
        active: Pipewire.ready && mixerButton.toggle

        PopupWindow {
            id: mixerWindow
            anchor.window: root
            anchor.rect.x: parentWindow.width
            anchor.rect.y: parentWindow.height + 5
            implicitWidth: 750
            implicitHeight: 750
            visible: true


            PwNodeLinkTracker {
                id: nodeLinkTracker
                node: Pipewire.defaultAudioSink
            }

            PwObjectTracker {
                objects: Pipewire.defaultAudioSink
            }

            Column {
                id: mixerEntries
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
