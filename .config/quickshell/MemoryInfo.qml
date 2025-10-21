pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property var total: 0
    property var free: 0
    property var available: 0
    Process {
        id: proc
        command: ["cat", "/proc/meminfo"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                text.split('\n').forEach(e => {
                    const [key, value] = (e.replace(/( |(kB))/g, "").split(":"))

                    // Classic if else
                    if (key == "MemTotal") total = value;
                    else if (key == "MemFree") free = value;
                    else if (key == "MemAvailable") available = value;
                });
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: proc.running = true;
    }
}
