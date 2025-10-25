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

    ColumnLayout {
        id: content

        //anchors.left: parent.left
        //anchors.right: parent.right
        spacing: 8

        MediaInfo {
            Layout.fillWidth: true
            Layout.leftMargin: Config.style.spacing.sm
            Layout.topMargin: Config.style.spacing.sm
            Layout.rightMargin: Config.style.spacing.sm
        }

        MediaSliderPanel {
        }

        MprisControls {
            id: controls

            Layout.fillWidth: false
            Layout.topMargin: -Config.style.spacing.sm * 0.5
            Layout.bottomMargin: Config.style.spacing.md
            Layout.alignment: Qt.AlignHCenter
            pointSize: 18
            player: Players.activePlayer
        }

    }

}
