import Quickshell
import QtQuick

Item {
    PanelWindow {
        id: panel
        implicitWidth: 100
        implicitHeight: 30
        exclusiveZone: 0
        aboveWindows: true
        color: '#00050d0d'

        anchors {
            top: true
        }

        margins {
            top: 15
        }

        ParallelAnimation {
            id: hoverAnim
            running: true
            NumberAnimation {
                target: panel
                property: "margins.top"
                to: 10
                duration: 75
            }
            NumberAnimation {
                target: panel
                property: "implicitWidth"
                to: 110
                duration: 75
            }
            NumberAnimation {
                target: panel
                property: "implicitHeight"
                to: 40
                duration: 75
            }
        }
        ParallelAnimation {
            id: unhoverAnim
            running: true
            NumberAnimation {
                target: panel
                property: "margins.top"
                to: 15
                duration: 75
            }
            NumberAnimation {
                target: panel
                property: "implicitWidth"
                to: 100
                duration: 75
            }
            NumberAnimation {
                target: panel
                property: "implicitHeight"
                to: 30
                duration: 75
            }
        }

        MouseArea {

            hoverEnabled: true
            anchors.fill: parent
            width: parent.width
            height: parent.height
            onEntered: {
                unhoverAnim.stop();
                hoverAnim.start();
            }
            onExited: {
                hoverAnim.stop();
                unhoverAnim.start();
            }

            Rectangle {
                id: rec
                anchors.fill: parent
                color: '#db2626'
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
