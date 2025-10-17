import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
    id: root
    required property var bar
    height: parent.height
    anchors.verticalCenter: parent.verticalCenter

    Repeater {
        property var hyprlandMonitor: Hyprland.monitorFor(root.bar.screen)
        model: Hyprland.workspaces.values.filter(e => e.monitor.id == hyprlandMonitor.id)

        BarButton {
            required property var modelData
            property bool selected: modelData.id == Hyprland.focusedWorkspace.id

            bar: root.bar
            text: modelData.id
            textColor: selected ? "cyan" : "white"

            onClicked: if (!selected) Hyprland.dispatch(`workspace ${modelData.id}`)
        }
    }

    BarButton {
        text: "+"
        textColor: "white"
        bar: root.bar

        onClicked: Hyprland.dispatch(`workspace ${Hyprland.workspaces.values[Hyprland.workspaces.values.length - 1].id + 1}`)
    }
}
