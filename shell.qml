// shell.qml
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

ShellRoot {
    Island {
        id: island
        menu: menu
    }

    Menu {
        id: menu
        island: island
    }
}
