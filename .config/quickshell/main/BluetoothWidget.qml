import QtQuick
import QtQuick.Controls
import Quickshell.Bluetooth
BarButton {
    text: "\udb80\udcaf"
    tooltipItem: Column {
        width: 300
        height: 400
        padding: 5

        CheckBox {
            checked: Bluetooth.defaultAdapter.enabled
            onToggled: {
                Bluetooth.defaultAdapter.enabled = checked
            }
            Text {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: "Enabled"
                color: "white"
            }
        }

        CheckBox {
            checked: Bluetooth.defaultAdapter.discovering
            onToggled: {
                Bluetooth.defaultAdapter.discovering = checked
                Bluetooth.defaultAdapter.pairable = checked
            }
            Text {
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: "Scanning"
                color: "white"
            }
        }

        Text {
            text: "Connected"
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            model: Bluetooth.devices.values.filter(e => e.connected)

            Text {
                leftPadding: 10
                required property var modelData
                text: modelData.name
                color: "white"
            }
        }

        Text {
            text: "Paired"
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            model: Bluetooth.defaultAdapter.devices.values.filter(e => e.paired && !e.connected)

            BetterButton {
                required property var modelData
                text: modelData.name
                textColor: "white"
                textSize: 15
                onClicked: modelData.forget()
            }
        }

        Text {
            text: "Pairing"
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            model: Bluetooth.defaultAdapter.devices.values.filter(e => e.pairing)

            BetterButton {
                required property var modelData
                text: modelData.name
                textColor: "white"
                textSize: 15
                onClicked: modelData.connect()
            }
        }

        Text {
            text: "Not Paired"
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            model: Bluetooth.defaultAdapter.devices.values.filter(e => !e.paired)

            BetterButton {
                required property var modelData
                height: 30
                width: parent.width - 10
                text: modelData.name
                textSize: 15
                onClicked: modelData.pair()
            }
            // Text {
            //     leftPadding: 10
            //     required property var modelData
            //     text: modelData.name
            //     color: "white"
            // }
        }
    }
}
