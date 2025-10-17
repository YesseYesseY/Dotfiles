import Quickshell
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
        anchor {
            window: root.bar
            rect {
                x: {
                    if (hoveredItem !== null) {
                        let itempos = hoveredItem.mapToItem(null, hoveredItem.width / 2, 0) // wtf
                        return itempos.x - (width / 2)
                    }
                    else if (lastHoveredItem !== null) {
                        let itempos = lastHoveredItem.mapToItem(null, lastHoveredItem.width / 2, 0) // wtf
                        return itempos.x - (width / 2)
                    }
                    return 0
                }
                y: 40
            }
        }

        implicitWidth: {
            let contentWidth = root.contentItem !== null ? root.contentItem.width : root.lastContentItem !== null ? root.lastContentItem.width : 0
            return Math.max(10, contentWidth) + 10
        }

        implicitHeight: {
            let contentHeight = root.contentItem !== null ? root.contentItem.height : root.lastContentItem !== null ? root.lastContentItem.height : 0
            return Math.max(10, contentHeight) + 10
        }

        visible: true
        color: "transparent"

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true

            Rectangle {
                id: tooltipRect
                anchors.fill: parent
                color: "#FF121212"
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
                                lastHoveredItem = null
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
