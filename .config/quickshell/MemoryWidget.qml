import Quickshell.Io
import QtQuick

BarButton {
    text: `\uefc5  ${(((MemoryInfo.total - MemoryInfo.available) / MemoryInfo.total) * 100).toFixed(2)}%`;
    tooltipItem: Column {
        padding: 10
        Text {
            text: `Total: ${MemoryInfo.total}`;
            font.pixelSize: 20;
            color: "white";
        }
        Text {
            text: `Free: ${MemoryInfo.free}`;
            font.pixelSize: 20;
            color: "white";
        }
        Text {
            text: `Available: ${MemoryInfo.available}`;
            font.pixelSize: 20;
            color: "white";
        }
    }
}
