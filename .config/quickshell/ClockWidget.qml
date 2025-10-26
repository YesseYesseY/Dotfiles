import QtQuick
import Quickshell
import QtQuick.Controls

BarButton {
    id: root
    text: Time.time
    hoverEffect: false
    // tooltipItem: Column {
    //     topPadding: 10
    //     Text {
    //         id: topText
    //         font.pixelSize: 45
    //         text: Time.date
    //         color: "white"
    //         anchors.horizontalCenter: parent.horizontalCenter
    //     }
    //     Grid {
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         columns: 7
    //         spacing: -1
    //         Repeater {
    //             model: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    //             Text {
    //                 required property var modelData
    //                 text: modelData
    //                 color: "white"
    //                 width: 60
    //                 horizontalAlignment: Text.AlignHCenter
    //                 font.pixelSize: 20
    //             }
    //         }
    //         Repeater {
    //             model: Time.calendarArray

    //             Rectangle {
    //                 required property var modelData
    //                 required property int index
    //                 property bool isCurrentDate: modelData.getDate() === Time.currentDate.getDate();
    //                 property bool isCurrentMonth: modelData.getMonth() === Time.currentDate.getMonth();
    //                 width: 60
    //                 height: 60
    //                 bottomLeftRadius: index === 28 ? 10 : 0
    //                 bottomRightRadius: index === 34 ? 10 : 0
    //                 color: "transparent"
    //                 border {
    //                     width: 2
    //                     color: "cyan"
    //                 }

    //                 Canvas {
    //                     anchors.fill: parent
    //                     visible: isCurrentMonth && isCurrentDate
    //                     onPaint: {
    //                         if (visible) {
    //                             const lineCount = 7;
    //                             const ctx = getContext("2d");
    //                             ctx.strokeStyle = "cyan"

    //                             for (let i = 1; i <= lineCount; i++) {
    //                                 const off = (width / lineCount) * i;
    //                                 ctx.beginPath();
    //                                 ctx.moveTo(off, 0);
    //                                 ctx.lineTo(0, off)
    //                                 ctx.moveTo(off, height);
    //                                 ctx.lineTo(height, off);
    //                                 ctx.stroke();
    //                             }
    //                         }
    //                     }
    //                 }

    //                 Text {
    //                     anchors.centerIn: parent
    //                     text: modelData.getDate()
    //                     color: !isCurrentMonth ? "gray" : "white"
    //                     font.pixelSize: 25
    //                 }
    //             }
    //         }
    //     }
    // }
}
