import QtQuick.Layouts
import Quickshell
import Quickshell
import qs.config
import qs.modules.media
import qs.services

PanelWindow {
    id: root

    color: "transparent"
    aboveWindows: false
    anchors.left: true
    anchors.bottom: true
    implicitWidth: 460
    implicitHeight: layout.implicitHeight

    margins {
        left: Config.style.spacing.md
        bottom: Config.style.spacing.md
    }

    ColumnLayout {
        id: layout

        spacing: Config.style.spacing.md

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        MediaInfoPanel {
            active: !!Players.activePlayer
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        }

        MediaSliderPanel {
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.fillWidth: true
        }

        MprisControls {
            player: Players.activePlayer
        }

        MediaVolumePanel {
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.fillWidth: true
        }

    }

}
