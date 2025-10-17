pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string time: {
        Qt.formatDateTime(clock.date, "hh:mm")
    }
    property string date: {
        Qt.formatDateTime(clock.date, "ddd MMM d yyyy")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
