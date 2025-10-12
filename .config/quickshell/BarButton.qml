import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
    height: parent.height
    width: 35
    color: hovered ? "#44FFFFFF" : "transparent"

    property bool toggle: false
    property bool hovered: false
    property string text: ""
    property int textSize: 25
    property string textColor: "white"
    property string source: ""

    signal clicked(mouse: MouseEvent)

    onSourceChanged: {
        // Literally only tested on spotify lol
        if (source.includes("?path=")) {
            var pathIndex = source.indexOf("?path=")
            source = source.substr(pathIndex + 6) + "/" + source.substr(13, pathIndex - 13)
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.hovered = true
        onExited: parent.hovered = false
        onClicked: (mouse) => {
            parent.toggle = !parent.toggle
            parent.clicked(mouse)
        }
    }

    Text {
        id: textComp
        visible: parent.source == ""
        text: parent.text
        color: textColor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: parent.textSize
    }

    Image {
        source: parent.source
        height: 25
        width: 25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
