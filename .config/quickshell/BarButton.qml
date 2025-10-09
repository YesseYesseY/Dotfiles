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
    property string source: ""

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.hovered = true
        onExited: parent.hovered = false
        onClicked: {
            parent.toggle = !parent.toggle
        }
    }

    Text {
        visible: parent.source == ""
        text: parent.text
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 25
    }

    Image {
        source: parent.source
        height: 25
        width: 25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
