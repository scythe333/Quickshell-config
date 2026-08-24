pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

MouseArea {
    id: widgetMouseArea

    required property GridLayout grid
    required property int index

    implicitWidth: 65
    implicitHeight: 65
    hoverEnabled: true

    property bool isMouseInWidgetMouseArea: false

    onEntered: {
        isMouseInWidgetMouseArea = true;
    }

    onExited: {
        isMouseInWidgetMouseArea = false;
    }

    onClicked: {
        grid.visible = false;
    }

    Rectangle {
        anchors.centerIn: parent

        radius: 15
        color: "#e0e1dd"

        width: parent.isMouseInWidgetMouseArea ? 75 : 65

        height: parent.isMouseInWidgetMouseArea ? 75 : 65

        Behavior on width {
            NumberAnimation {
                duration: 50
            }
        }

        Behavior on height {
            NumberAnimation {
                duration: 50
            }
        }

        Text {
            anchors.centerIn: parent
            color: "#0d1b2a"

            text: {
                switch (widgetMouseArea.index) {
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
                    return "RU";
                case 6:
                    return String.fromCodePoint(0xf0f3);
                case 7:
                    return String.fromCodePoint(0xf0387);
                default:
                    return "";
                }
            }

            font {
                family: "SF Mono"
                pixelSize: 40
                weight: 500
                letterSpacing: 0
            }
        }
    }
}
