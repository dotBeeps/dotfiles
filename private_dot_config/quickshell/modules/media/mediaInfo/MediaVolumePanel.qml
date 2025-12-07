import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.config
import qs.modules.audio
import qs.services

ClippingWrapperRectangle {
    id: root

    radius: Config.style.rounding.small
    color: Config.colors.base.darker(1.5).alpha(0.9)
    margin: Config.style.spacing.sm
    leftMargin: Config.style.spacing.md
    rightMargin: Config.style.spacing.md

    ColumnLayout {
        Loader {
            active: !!Audio.defaultSink
            Layout.fillWidth: true
            Layout.leftMargin: Config.style.spacing.xs
            Layout.topMargin: Config.style.spacing.xs
            Layout.rightMargin: Config.style.spacing.xs

            sourceComponent: VolumeControl {
                id: volControls

                anchors.fill: parent
                iconButton.text: "󰓃"
                iconButton.font.pointSize: Config.style.fonts.ptMd
                slider.value: Audio.volume
                slider.color: Config.colors.accentSecondary
                slider.onMoved: {
                    Audio.setVolume(slider.value);
                }
            }

        }

        Loader {
            active: !!Audio.defaultSource
            Layout.fillWidth: true
            Layout.leftMargin: Config.style.spacing.xs
            Layout.rightMargin: Config.style.spacing.xs
            Layout.bottomMargin: Config.style.spacing.xs

            sourceComponent: VolumeControl {
                id: micControls

                anchors.fill: parent
                iconButton.text: ""
                iconButton.font.pointSize: Config.style.fonts.ptLg
                slider.value: Audio.sourceVolume
                slider.color: Config.colors.accent
                slider.onMoved: {
                    Audio.setSourceVolume(slider.value);
                }
            }

        }

    }

}
