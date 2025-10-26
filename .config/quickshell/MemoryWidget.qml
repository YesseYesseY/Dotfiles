import Quickshell.Io
import QtQuick

BarButton {
    text: `\uefc5  ${(((MemoryInfo.total - MemoryInfo.available) / MemoryInfo.total) * 100).toFixed()}%`;
}
