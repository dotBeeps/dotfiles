import QtQuick
import QtQuick.Controls

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
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: root.active ? Config.colors.urgent : (root.hovered || root.hint) ? Config.colors.text : Config.colors.inactive

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
