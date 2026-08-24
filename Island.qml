// Island.qml
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    id: island

    // Menu.qml is passed in from shell.qml
    required property Menu menu

    // Expose the internal MouseArea state
    property alias mouseInIsland: islandMouseArea.isMouseInIslandMouseArea

    implicitWidth: 130
    implicitHeight: 40
    exclusiveZone: 0
    aboveWindows: true
    color: "#00111111"

    anchors {
        top: true
    }

    margins {
        top: 5
    }

    MouseArea {
        id: islandMouseArea

        anchors.fill: parent
        hoverEnabled: true

        width: isMouseInIslandMouseArea || island.menu.mouseInMenu ? 130 : 110

        height: isMouseInIslandMouseArea || island.menu.mouseInMenu ? 40 : 30

        property bool isMouseInIslandMouseArea: false

        onEntered: {
            isMouseInIslandMouseArea = true;
            island.menu.openMenu();
        }

        onExited: {
            isMouseInIslandMouseArea = false;

            if (!island.menu.mouseInMenu) {
                island.menu.startHideTimer();
            }
        }

        Rectangle {
            //ISLAND BG
            anchors.centerIn: parent

            color: "#0d1b2a"
            radius: 25

            width: parent.isMouseInIslandMouseArea || island.menu.mouseInMenu ? 130 : 110

            height: parent.isMouseInIslandMouseArea || island.menu.mouseInMenu ? 40 : 30

            Behavior on width {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.OutQuad
                }
            }

            Behavior on height {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.OutQuad
                }
            }
        }
    }

    Text {
        anchors.centerIn: parent

        text: Qt.formatDateTime(clock.date, "hh:mm")
        color: "#e0e1dd"

        font {
            family: "SF Mono"
            letterSpacing: -1
            pixelSize: 17
            weight: 800
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
