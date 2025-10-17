import QtQuick
import Quickshell
import QtQuick.Controls

BarButton {
    id: root
    text: Time.time
    anchors.centerIn: parent
    tooltipItem: Text {
        font.pixelSize: 25
        text: Time.date
        color: "white"
    }

    LazyLoader {
        active: true

    }
}
