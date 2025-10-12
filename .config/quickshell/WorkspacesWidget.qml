import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
    height: parent.height
    id: leftSideRow
    anchors.verticalCenter: parent.verticalCenter

    Repeater {
        property var hyprlandMonitor: Hyprland.monitorFor(root.screen)
        model: Hyprland.workspaces.values.filter(e => e.monitor.id == hyprlandMonitor.id)

        BarButton {
            required property var modelData
            property bool selected: modelData.id == Hyprland.focusedWorkspace.id

            text: modelData.id
            textColor: selected ? "purple" : "white"

            onClicked: Hyprland.dispatch(`workspace ${modelData.id}`)
        }
    }

    BarButton {
        text: "+"
        textColor: "white"

        onClicked: Hyprland.dispatch(`workspace ${Hyprland.workspaces.values[Hyprland.workspaces.values.length - 1].id + 1}`)
    }
}
