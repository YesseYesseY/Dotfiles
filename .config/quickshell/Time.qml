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

    property var currentDate: new Date();
    property var calendarArray: {
        const firstDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
        const lastDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);
        const firstDayOfCalendar = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1 - currentDate.getDay())
        const ret = [];
        let off = 1 - getDayReal(firstDayOfMonth);
        for (let i = off; i < 35 + off; i++) {
            ret.push(new Date(currentDate.getFullYear(), currentDate.getMonth(), i));
        }
        return ret;
    }
    /*
     *  Total elements: 35
     *
     *  0   1   2   3   4   5   6    // Because i live in a normal place where weeks begin on monday
     *  Mon Tue Wed Thu Fri Sat Sun
     *  29  30  1   2   3   4   5
     *  6   7   8   9   10  11  12
     *  13  14  15  16  17  18  19
     *  20  21  22  23  24  25  26
     *  27  28  29  30  31  1   2
     *
     * */

    function getDayReal(datetofix) {
        let fake = datetofix.getDay();
        if (fake > 0) fake--;
        else fake = 6;
        return fake
    }

    function stringifySeconds(secs) {
        let min = Math.floor(secs / 60);
        let hours = Math.floor(min / 60);
        let ret = "";
        if (hours > 0) ret += `${hours}:`;
        hours > 0 ? ret += `${(min % 60).toString().padStart(2, "0")}:` : ret += `${min}:`;
        ret += `${Math.floor(secs % 60).toString().padStart(2, "0")}`;
        return ret;
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
