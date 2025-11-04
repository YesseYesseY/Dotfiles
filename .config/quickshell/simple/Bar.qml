import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.UPower
import QtQuick

PanelWindow {
    id: root
    required property var modelData

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 40
    color: "#000000"

    Row {
        anchors.right: parent.right
        rightPadding: 5

        SimpleText {
            text: `\udb80\udc79${(UPower.displayDevice.percentage * 100).toFixed()}%`
        }

        SimpleSeperator { }

        SimpleText {
            text: Qt.formatDateTime(clock.date, "hh:mm")

            SystemClock {
                id: clock
                precision: SystemClock.Seconds
            }
        }
    }


    Row {
        Repeater {
            property var hyprlandMonitor: Hyprland.monitorFor(root.modelData)
            model: Hyprland.workspaces.values.filter(e => e.monitor.id == hyprlandMonitor.id)

            SimpleText {
                required property var modelData
                text: modelData.focused ? `[${modelData.id}]` : ` ${modelData.id} `
            }
        }
    }
}
