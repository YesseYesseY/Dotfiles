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
                window: bar
                edges: Edges.Top | Edges.Right
                gravity: Edges.Bottom | Edges.Left
                rect {
                    x: {
                        let itempos = parent.mapToItem(null, parent.width / 2, 0); // wtf
                        return itempos.x;
                    }
                    y: 40
                }
            }
        }
    }
}
