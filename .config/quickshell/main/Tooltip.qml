import Quickshell
import Quickshell.Hyprland
import QtQuick

Scope {
    id: root
    required property var bar
    property Item hoveredItem: null
    property Item lastHoveredItem: null
    property Item contentItem: null
    property Item lastContentItem: null

    onContentItemChanged: {
        if (lastContentItem !== null) {
            lastContentItem.parent = null
        }
        if (contentItem !== null) {
            contentItem.parent = tooltipRect
            contentItem.anchors.centerIn = tooltipRect
        }
    }

    PopupWindow {
        id: win
        anchor {
            window: root.bar
            rect {
                x: 10
                y: 50
            }
        }

        implicitWidth: {
            return root.bar.width - 20;
            // let contentWidth = root.contentItem !== null ? root.contentItem.width : root.lastContentItem !== null ? root.lastContentItem.width : 0
            // return Math.max(10, contentWidth)
        }

        implicitHeight: {
            return root.bar.modelData.height - root.bar.height - 20;
            // let contentHeight = root.contentItem !== null ? root.contentItem.height : root.lastContentItem !== null ? root.lastContentItem.height : 0
            // return Math.max(10, contentHeight)
        }

        visible: tooltipRect.opacity == 0 ? false : true
        color: "transparent"

        MouseArea {
            id: mouseArea
            hoverEnabled: true
            width: {
                let contentWidth = root.contentItem !== null ? root.contentItem.width : root.lastContentItem !== null ? root.lastContentItem.width : 0;
                return Math.max(10, contentWidth);
            }
            height: {
                let contentHeight = root.contentItem !== null ? root.contentItem.height : root.lastContentItem !== null ? root.lastContentItem.height : 0;
                return Math.max(10, contentHeight);
            }
            x: {
                if (hoveredItem === null) {
                    if (lastHoveredItem === null) return 0;

                    let itempos = lastHoveredItem.mapToItem(null, lastHoveredItem.width / 2, 0); // wtf
                    return MathFuncs.clamp(0, itempos.x - (width / 2), root.bar.width - width - 20);
                } else {
                    let itempos = hoveredItem.mapToItem(null, hoveredItem.width / 2, 0); // wtf
                    return MathFuncs.clamp(0, itempos.x - (width / 2), root.bar.width - width - 20);
                }
            }
            Behavior on x { NumberAnimation { duration: 100; } }

            Rectangle {
                id: tooltipRect
                anchors.fill: parent
                // anchors.centerIn: parent
                color: "#FF121212"
                radius: 10
                border {
                    width: 2
                    color: "cyan"
                }
                opacity: {
                    if (hoveredItem === null) {
                        if (lastHoveredItem !== null && mouseArea.containsMouse) return 1
                        return 0
                    }
                    return 1
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 100
                        onRunningChanged: {
                            if (!running && tooltipRect.opacity === 0) {
                                lastContentItem = contentItem
                                contentItem = null
                            }
                        }
                    }
                }
            } 
        }
    }
}
