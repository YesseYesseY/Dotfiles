pragma Singleton

import Quickshell

Singleton {
    function clamp(min, val, max) {
        if (val < min) val = min;
        if (val > max) val = max;
        return val;
    }
}
