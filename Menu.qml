// Menu.qml
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

PopupWindow {
    id: menuPanel

    required property Island island

    // Expose menu state to Island.qml
    property alias menuOpen: menuMouseArea.isMenuOpen
    property alias mouseInMenu: menuMouseArea.isMouseInMenuMouseArea

    implicitWidth: 350
    implicitHeight: 175

    anchor.window: island
    anchor.rect.x: island.width / 2 - width / 2
    anchor.rect.y: island.height

    visible: menuMouseArea.isMenuOpen
    color: "#001e1818"

    function openMenu() {
        menuMouseArea.isMenuOpen = true;
        hideTimer.stop();
    }

    function startHideTimer() {
        hideTimer.restart();
    }

    Timer {
        id: hideTimer

        interval: 1
        repeat: false

        onTriggered: {
            if (!menuPanel.island.mouseInIsland && !menuMouseArea.isMouseInMenuMouseArea) {
                menuMouseArea.isMenuOpen = false;
            }
        }
    }

    MouseArea {
        //MENU MOUSE AREA
        id: menuMouseArea

        anchors.fill: parent
        hoverEnabled: true

        property bool isMouseInMenuMouseArea: false
        property bool isMenuOpen: false

        onEntered: {
            isMouseInMenuMouseArea = true;
            isMenuOpen = true;
            hideTimer.stop();
        }

        onExited: {
            isMouseInMenuMouseArea = false;

            if (!menuPanel.island.mouseInIsland) {
                hideTimer.restart();
            }
        }

        Rectangle {
            //MENU BG
            id: menu

            anchors.fill: parent
            color: "#0d1b2a"
            radius: 25

            GridLayout {
                //WIDGETS
                id: grid

                anchors.centerIn: parent

                visible: true
                rowSpacing: 15
                columnSpacing: 15
                rows: 2
                columns: 4

                Repeater {
                    model: 8
                    Widgets {
                        grid: grid
                    }
                }
            }
        }
    }
}
