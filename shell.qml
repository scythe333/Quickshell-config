import Quickshell
import QtQuick
import QtQuick.Layouts

ShellRoot {
    PopupWindow {
        id: menuPanel

        implicitWidth: 350
        implicitHeight: 175
        anchor.window: island
        anchor.rect.x: parentWindow.width / 2 - width / 2
        anchor.rect.y: parentWindow.height
        visible: menuMouseArea.isMenuOpen
        color: '#001e1818'

        Timer {
            id: hideTimer

            interval: 1
            repeat: false

            onTriggered: {
                if (!islandMouseArea.isMouseInIslandMouseArea && !menuMouseArea.isMouseInMenuMouseArea) {
                    menuMouseArea.isMenuOpen = false;
                }
            }
        }

        MouseArea {
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

                if (!islandMouseArea.isMouseInIslandMouseArea) {
                    hideTimer.restart();
                }
            }

            Rectangle {
                id: menu
                color: '#061117'
                radius: 25
                anchors.fill: parent

                GridLayout {
                    id: grid
                    visible: true
                    anchors.centerIn: parent
                    rowSpacing: widgetMouseAreas.isMouseInWidgetMouseArea ? 5 : 10
                    columnSpacing: widgetMouseAreas.isMouseInWidgetMouseArea ? 5 : 10
                    rows: 2
                    columns: 4
                    //67
                    Repeater {
                        model: 8

                        MouseArea {
                            id: widgetMouseAreas

                            hoverEnabled: true
                            required property int index
                            property bool isMouseInWidgetMouseArea

                            implicitWidth: isMouseInWidgetMouseArea ? 75 : 65
                            implicitHeight: isMouseInWidgetMouseArea ? 75 : 65

                            onEntered: {
                                isMouseInWidgetMouseArea = true;
                            }

                            onExited: {
                                isMouseInWidgetMouseArea = false;
                            }

                            Rectangle {
                                radius: 15
                                anchors.fill: parent
                                color: '#f5e2c5'

                                Behavior on implicitWidth {
                                    NumberAnimation {
                                        duration: 300
                                    }
                                }

                                Behavior on implicitHeight {
                                    NumberAnimation {
                                        duration: 300
                                    }
                                }

                                Text {
                                    anchors.centerIn: parent

                                    text: {
                                        switch (widgetMouseAreas.index) {
                                        case 0:
                                            return String.fromCodePoint(0xf00e0);
                                        case 1:
                                            return String.fromCodePoint(0xefcf);
                                        case 2:
                                            return String.fromCodePoint(0xf240);
                                        case 3:
                                            return String.fromCodePoint(0xf0a32);
                                        case 4:
                                            return String.fromCodePoint(0xf05a9);
                                        case 5:
                                            return 'RU';
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
                        }
                    }
                }
            }
        }
    }

    PanelWindow {
        id: island

        implicitWidth: 130
        implicitHeight: 40
        exclusiveZone: 0
        aboveWindows: true
        color: '#00111111'

        anchors {
            top: true
        }

        margins {
            top: 5
        }

        MouseArea {
            id: islandMouseArea

            hoverEnabled: true
            anchors.fill: parent

            width: isMouseInIslandMouseArea || menuMouseArea.isMouseInMenuMouseArea ? 130 : 110

            height: isMouseInIslandMouseArea || menuMouseArea.isMouseInMenuMouseArea ? 40 : 30

            property bool isMouseInIslandMouseArea: false

            onEntered: {
                isMouseInIslandMouseArea = true;
                menuMouseArea.isMenuOpen = true;
                hideTimer.stop();
            }

            onExited: {
                isMouseInIslandMouseArea = false;

                if (!menuMouseArea.isMouseInMenuMouseArea) {
                    hideTimer.restart();
                }
            }

            Rectangle {
                anchors.centerIn: parent

                color: '#061117'
                radius: 25

                width: parent.isMouseInIslandMouseArea || menuMouseArea.isMouseInMenuMouseArea ? 130 : 110

                height: parent.isMouseInIslandMouseArea || menuMouseArea.isMouseInMenuMouseArea ? 40 : 30

                Behavior on height {
                    NumberAnimation {
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                }

                Behavior on width {
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
