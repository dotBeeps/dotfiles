import QtQuick
import QtQuick.Controls
import qs.config

Button {
    id: root

    property bool active: false
    property bool hint: false
    property alias color: buttonText.color

    flat: true
    display: AbstractButton.TextOnly
    hoverEnabled: true

    contentItem: Text {
        id: buttonText

        text: root.text
        font: root.font
        anchors.fill: root
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: root.active ? Config.activeColors.urgent : (root.hovered || root.hint) ? Config.activeColors.text : Config.activeColors.inactive

        Behavior on color {
            ColorAnimation {
                duration: 200

                easing {
                    type: Easing.InOutCubic
                }

            }

        }

    }

    background: Item {
    }

}
