import QtQuick
import QtQuick.Controls
import qs.config

Item {
    id: root

    property bool popoutShown: false

    Button {
        id: button

        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.popoutShown = !root.popoutShown;
        }

        contentItem: MediaInfoBar {
            id: info

            anchors.fill: parent
        }

        background: Rectangle {
            id: buttonBg

            color: Config.activeColors.highlight
            opacity: button.hovered ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }

            }

        }

    }

    MediaPopout {
        anchors.fill: button
        popoutShown: root.popoutShown
        offsetX: root.x + 8
    }

}
