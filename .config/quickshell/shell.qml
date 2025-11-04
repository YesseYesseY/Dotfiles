import Quickshell
import QtQuick

// import "main"
import "simple"

Scope {
    Variants {
        model: Quickshell.screens;

        Bar {
        }
    }
}
