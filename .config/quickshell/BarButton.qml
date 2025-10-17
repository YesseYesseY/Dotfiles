import QtQuick

BetterButton {
    id: root
    height: bar.height
    
    required property var bar
    property Item tooltipItem: null

    onEntered: {
        if (tooltipItem !== null) {
            root.bar.tooltip.hoveredItem = root
            root.bar.tooltip.contentItem = root.tooltipItem
        }
    }

    onExited: {
        if (tooltipItem !== null) {
            root.bar.tooltip.lastHoveredItem = root.bar.tooltip.hoveredItem
            root.bar.tooltip.hoveredItem = null
        }
    }
}
