import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
    id: root
    height: base.height
    width: Math.max(35, textComp.width);
    color: hovered ? "#44FFFFFF" : "transparent"

    required property var bar

    property bool toggle: false
    property bool hovered: false
    property string text: ""
    property int textSize: 25
    property string textColor: "white"
    property string source: ""
    property Item tooltipItem: null

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
        onEntered: {
            parent.hovered = true
            if (tooltipItem !== null) {
                root.bar.tooltip.hoveredItem = root
                root.bar.tooltip.contentItem = root.tooltipItem
            }
        }
        onExited: {
            parent.hovered = false
            if (tooltipItem !== null) {
                root.bar.tooltip.lastHoveredItem = root.bar.tooltip.hoveredItem
                root.bar.tooltip.hoveredItem = null
            }
        }
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
