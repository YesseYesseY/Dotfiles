import Quickshell.Io
import QtQuick

BarButton {
    hoverEffect: false
    text: `\uefc5  ${(((MemoryInfo.total - MemoryInfo.available) / MemoryInfo.total) * 100).toFixed()}%`;
}
