import Quickshell
import QtQuick
import QtQuick.Layouts

ShellRoot {
    PopupWindow {
        id: menuPanel
        property bool islandOpened: false
        implicitWidth: 288
        implicitHeight: 144
        anchor.window: panel
        anchor.rect.x: parentWindow.width / 2 - width / 2
        anchor.rect.y: parentWindow.height
        visible: islandOpened
        color: '#001e1818'

        Rectangle {
            id: menu
            color: '#061117'
            anchors.fill: parent
            radius: 25

            GridLayout {
                id: grid
                visible: true
                anchors.fill: parent
                rowSpacing: -12
                columnSpacing: -12
                rows: 2
                columns: 4

                Repeater {
                    id: repeater
                    model: 8
                    delegate: MouseArea {
                        id: menuMouseAreas
                        required property int index
                        Layout.leftMargin: 12
                        Layout.rightMargin: 12
                        Layout.topMargin: 12
                        Layout.bottomMargin: 12
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Rectangle {
                            radius: 15
                            anchors.fill: parent
                            color: '#f5e2c5'
                            Text {
                                anchors.centerIn: parent
                                text: {
                                    switch (menuMouseAreas.index) {
                                    case 0:
                                        return String.fromCodePoint(0xf0a32);
                                    case 1:
                                        return String.fromCodePoint(0xefcf);
                                    case 2:
                                        return String.fromCodePoint(0xf240);
                                    case 3:
                                        return String.fromCodePoint(0xf05a9);
                                    case 4:
                                        return String.fromCodePoint(0xf00e0);
                                    case 5:
                                        return 'ru';
                                    case 6:
                                        return String.fromCodePoint(0xf0f3);
                                    case 7:
                                        return String.fromCodePoint(0xf1ec);
                                    default:
                                        return '';
                                    }
                                }
                                font {
                                    family: "SF Mono"
                                    pixelSize: 40
                                    weight: 500
                                    letterSpacing: -1
                                }
                            }
                        }
                        Behavior on implicitHeight {
                            id: menuAnim1
                            NumberAnimation {
                                target: menuPanel
                                property: "implicitHeight"
                                to: 400
                                duration: 1000
                                easing.type: Easing.OutCubic
                            }
                        }
                        onClicked: {
                            grid.visible = false;
                            if (menuMouseAreas.index === 0) {
                                implicitHeight = 400;
                            }
                        }
                    }
                }
            }
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
