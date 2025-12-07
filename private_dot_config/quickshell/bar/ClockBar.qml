import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.config
import qs.services

WrapperRectangle {
    color: "transparent"
    radius: Config.style.bar.radius
    implicitHeight: parent.height

    RowLayout {
        WrapperItem {
            leftMargin: Config.style.spacing.md
            rightMargin: Config.style.spacing.md

            Text {
                text: Time.date
                color: Config.colors.text

                font {
                    family: Config.style.fonts.mono
                    pointSize: Config.style.bar.fontSize
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
            leftMargin: Config.style.spacing.md
            rightMargin: Config.style.spacing.md

            Text {
                text: Time.time
                color: Config.colors.text

                font {
                    family: Config.style.fonts.mono
                    pointSize: Config.style.bar.fontSize
                }

            }

        }

    }

}
