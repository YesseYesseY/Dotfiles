// Idk what else to call it if not QuickMenu lol

import Quickshell
import QtQuick

BarButton {
    required property var barRect

    id: root
    width: height
    text: "\uf359"
    onClicked: barRect.bottomLeftRadius = toggle ? 0 : 10

    PopupWindow {
        anchor {
            item: root
            rect {
                y: root.bar.height - 2
            }
        }
        width: 500
        height: 500
        color: "transparent"
        visible: root.toggle

        Rectangle {
            anchors.fill: parent
            color: "#FF121212"
            radius: 10
            topLeftRadius: 0
            topRightRadius: 0
            border {
                color: "#00FFFF"
                width: 2
            }

            Rectangle {
                color: parent.color
                width: parent.width - 4
                height: 2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
            }
        }
    }
}
