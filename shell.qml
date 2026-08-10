import Quickshell
import QtQuick
import QtQuick.Controls

ShellRoot {
    PopupWindow {
        id: menuPanel
        property bool islandOpened: false
        implicitWidth: 300
        implicitHeight: 100
        anchor.window: panel
        anchor.rect.x: parentWindow.width / 2 - width / 2
        anchor.rect.y: parentWindow.height
        visible: islandOpened
        color: '#00111111'

        Rectangle {
            id: menu
            color: '#061117'
            anchors.fill: parent
            radius: 25
        }
    }
    PanelWindow {
        id: panel
        implicitWidth: 100
        implicitHeight: 30
        exclusiveZone: 0
        aboveWindows: true
        color: '#00111111'

        anchors {
            top: true
        }

        margins {
            top: 15
        }

        ParallelAnimation {
            id: hoverAnim
            running: false
            NumberAnimation {
                target: panel
                property: "margins.top"
                to: 10
                duration: 75
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: panel
                property: "implicitWidth"
                to: 110
                duration: 75
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: panel
                property: "implicitHeight"
                to: 40
                duration: 75
                easing.type: Easing.OutQuad
            }
        }
        ParallelAnimation {
            id: unhoverAnim
            running: false
            NumberAnimation {
                target: panel
                property: "margins.top"
                to: 15
                duration: 75
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: panel
                property: "implicitWidth"
                to: 100
                duration: 75
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: panel
                property: "implicitHeight"
                to: 30
                duration: 75
                easing.type: Easing.OutQuad
            }
        }

        MouseArea {
            id: islandMouseArea
            hoverEnabled: true
            anchors.fill: parent
            width: parent.width
            height: parent.height
            onClicked: {
                if (menuPanel.islandOpened == true) {
                    menuPanel.islandOpened = false;
                } else {
                    menuPanel.islandOpened = true;
                }
            }

            onEntered: {
                unhoverAnim.stop();
                hoverAnim.start();
            }
            onExited: {
                if (menuPanel.islandOpened == false) {
                    hoverAnim.stop();
                    unhoverAnim.start();
                }
            }

            Rectangle {
                id: island
                anchors.fill: parent
                color: '#061117'
                radius: 25
            }
        }

        Text {
            anchors.centerIn: parent
            text: Qt.formatDateTime(clock.date, "hh:mm")
            color: "#f5e2c5"

            font {
                family: "SF Mono"
                letterSpacing: -1
                pixelSize: 17
                weight: 800
            }
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
