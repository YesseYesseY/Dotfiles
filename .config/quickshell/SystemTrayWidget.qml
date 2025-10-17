import Quickshell
import QtQuick
import Quickshell.Services.SystemTray

Repeater {
    id: root
    required property var bar
    model: SystemTray.items

    BarButton {
        required property var modelData
        source: modelData.icon
        onClicked: sysTrayMenuAnchor.open()
        bar: root.bar

        QsMenuAnchor {
            id: sysTrayMenuAnchor
            menu: modelData.menu
            anchor {
                item: parent
                edges: Edges.Top | Edges.Right
                gravity: Edges.Bottom | Edges.Left
                margins {
                    top: 40
                }
            }
        }
    }
}
