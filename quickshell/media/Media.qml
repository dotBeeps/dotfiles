import ".."
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Mpris

Item {
    id: root

    required property QsWindow window
    property MprisPlayer currentPlayer: Mpris.players.values.filter((p) => {
        return p.isPlaying;
    })[0] ?? null
    property bool popoutShown: false

    Button {
        id: button

        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.popoutShown = !root.popoutShown;
        }

        contentItem: MprisInfo {
            id: info

            player: root.currentPlayer
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

    MediaPopout {
        window: root.window
        anchors.fill: button
        player: root.currentPlayer
        popoutShown: root.popoutShown
        offsetX: root.x + 8
    }

}
