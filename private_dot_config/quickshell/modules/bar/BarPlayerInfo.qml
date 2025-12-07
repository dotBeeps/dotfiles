import QtQuick
import QtQuick.Controls
import Quickshell
import qs.config
import qs.modules.common

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

        contentItem: BarPlayerInfoContent {
            id: info

            anchors.fill: parent
        }

        background: Rectangle {
            id: buttonBg

            color: Config.colors.highlight
            opacity: button.hovered ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }

            }

        }

    }

    BarMediaPopout {
        shown: root.popoutShown
        anchor.window: QsWindow.window
        anchor.rect.y: Config.style.bar.height + Config.gaps.xs
        margin: Config.gaps.xs
    }

}
