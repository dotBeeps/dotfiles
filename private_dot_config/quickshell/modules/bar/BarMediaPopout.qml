import QtQuick
import QtQuick.Layouts
import qs.config
import qs.modules.common
import qs.modules.media
import qs.modules.media.mediaInfo
import qs.services
import Quickshell.Widgets

StyledPopup {
    id: root
    popupColor: Config.colors.base.darker(1)
    hyprOpacity: .95

    WrapperRectangle {
        color: "transparent"
        margin: Config.gaps.sm
        radius: root.radius - 6
        border {
            width: 2
            color: Config.colors.base.lighter(1.8).alpha(.4)
        }
        RowLayout {
            id: layout
            spacing: Config.gaps.sm
            ColumnLayout {
                Layout.preferredWidth: 500
                Players.ActiveArt {
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    radius: Config.style.rounding.medium
                }
                Players.ActiveTitle {
                    Layout.leftMargin: Config.gaps.xs
                    Layout.rightMargin: Config.gaps.xs
                    Layout.fillWidth: true
                }
                Players.ActiveArtist {
                    Layout.fillWidth: true
                    Layout.topMargin: -6
                    Layout.leftMargin: Config.gaps.xs
                    Layout.rightMargin: Config.gaps.xs
                    color: Config.colors.accent
                }
            }

            Rectangle {
                Layout.preferredWidth: 2
                Layout.fillHeight: true
                radius: 3
                color: Config.colors.highlight.alpha(.5)
            }
        
            ColumnLayout {
                MediaSliderPanel {
                    Layout.fillWidth: true
                    color: Config.colors.base.darker(1.67)
                }

                MprisControls {
                    id: controls
                    Layout.fillWidth: true
                    pointSize: 18
                    radius: Config.style.rounding.small
                    player: Players.activePlayer
                    color: Config.colors.base.darker(1.67)
                }

                MediaVolumePanel {
                    Layout.fillWidth: true
                    color: Config.colors.base.darker(1.67)
                }
            }
        }
    }
}
