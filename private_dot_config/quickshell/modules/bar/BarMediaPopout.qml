import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.modules.common
import qs.modules.media
import qs.modules.media.mediaInfo
import qs.services

StyledPopup {
    id: root
    color: Config.activeColors.base.darker(1)
    hyprOpacity: .95

    ColumnLayout {
        id: content

        spacing: Config.style.spacing.xs

        MediaInfo {
            Layout.fillWidth: true
            Layout.topMargin: Config.gaps.sm
            Layout.rightMargin: Config.gaps.sm
            Layout.leftMargin: Config.gaps.sm
        }

        MediaSliderPanel {
            Layout.fillWidth: true
            Layout.rightMargin: Config.gaps.sm
            Layout.leftMargin: Config.gaps.sm
            color: Config.activeColors.base.darker(1.67)

        }

        MprisControls {
            id: controls
            Layout.fillWidth: true
            pointSize: 18
            Layout.rightMargin: Config.gaps.sm
            Layout.leftMargin: Config.gaps.sm
            radius: Config.style.rounding.small
            player: Players.activePlayer
            color: Config.activeColors.base.darker(1.67)
        }

        MediaVolumePanel {
            Layout.fillWidth: true
            Layout.rightMargin: Config.gaps.sm
            Layout.leftMargin: Config.gaps.sm
            color: Config.activeColors.base.darker(1.67)
            Layout.bottomMargin: Config.gaps.sm
        }

    }

}
