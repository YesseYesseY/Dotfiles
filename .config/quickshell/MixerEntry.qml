import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

Column {
    id: root
    required property var node
    Text {
        text: (node.description == "" ? node.name : node.description) + 
                (node.properties.hasOwnProperty("media.name") ? ` (${node.properties["media.name"]})` : "")
        font.pixelSize: 16
        leftPadding: 5
    }
    Row {
        spacing: 5
        leftPadding: 5
        bottomPadding: 10
        Button {
            id: muteButton
            width: 25
            height: 25

            text: {
                if (node.audio.muted)
                    return ""
                else
                    return ""
            }

            onClicked: {
                node.audio.muted = !node.audio.muted
            }
        }

        Slider {
            value: node.audio.volume
            onMoved: node.audio.volume = value
            anchors.verticalCenter: muteButton.verticalCenter
        }

    }
}
