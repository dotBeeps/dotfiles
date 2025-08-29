import ".."
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

WrapperRectangle {
    color: "transparent"
    radius: Config.bar.radius
    implicitHeight: parent.height

    RowLayout {
        WrapperItem {
            leftMargin: Config.gapMd
            rightMargin: Config.gapMd

            Text {
                text: Time.date
                color: Config.colors.text

                font {
                    family: fontMonofur.name
                    pointSize: Config.bar.fontSize
                }

            }

        }

        Rectangle {
            implicitHeight: parent.height * 0.75
            implicitWidth: 1
            color: Config.colors.text
            opacity: 0.65
        }

        WrapperItem {
            leftMargin: Config.gapMd
            rightMargin: Config.gapMd

            Text {
                text: Time.time
                color: Config.colors.text

                font {
                    family: fontMonofur.name
                    pointSize: Config.bar.fontSize
                }

            }

        }

    }

}
