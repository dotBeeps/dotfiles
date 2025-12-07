import QtQuick
import qs.config

Rectangle {
    id: root

    property real progress: 0
    property color innerColor: color.darker(3)
    property string text

    radius: 1000

    Rectangle {
        anchors.fill: parent
        anchors.margins: 2
        radius: height / 2
        color: root.innerColor

        Rectangle {
            color: Config.colors.accent
            radius: parent.radius
            implicitWidth: parent.width * root.progress + 0.5 * height

            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }

            Text {
                id: progressText

                visible: root.text
                anchors.fill: parent
                anchors.rightMargin: 8
                text: root.text
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter

                font {
                    family: Config.style.fonts.mono
                    pointSize: root.height / 2
                    wordSpacing: -4
                }

            }

        }

    }

}
