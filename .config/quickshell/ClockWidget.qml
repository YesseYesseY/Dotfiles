import QtQuick
import Quickshell
import QtQuick.Controls

BarButton {
    id: root
    text: Time.time
    anchors.centerIn: parent
    tooltipItem: Column {
        Text {
            id: topText
            font.pixelSize: 45
            text: Time.date
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Grid {
            anchors.horizontalCenter: parent.horizontalCenter
            columns: 7
            spacing: -1
            Repeater {
                model: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

                Text {
                    required property var modelData
                    text: modelData
                    color: "white"
                    width: 60
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                }
            }
            Repeater {
                model: Time.calendarArray

                Rectangle {
                    required property var modelData
                    width: 60
                    height: 60
                    color: "transparent"
                    border {
                        width: 1
                        color: "white"
                    }

                    Text {
                        anchors.centerIn: parent
                        text: modelData.getDate()
                        color: modelData.getMonth() == Time.currentDate.getMonth() ? "white" : "gray"
                        font.pixelSize: 25
                    }
                }
            }
        }
    }

    LazyLoader {
        active: true

    }
}
