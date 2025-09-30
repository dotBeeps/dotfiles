import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.modules.media

Item {
    id: root

    implicitHeight: content.implicitHeight

    GridLayout {
        id: content

        anchors.horizontalCenter: root.horizontalCenter
        width: root.width
        rows: 3
        columns: 2

        Text {
            text: Players.activePlayer?.trackArtist ?? ''
            color: Config.activeColors.text
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: Config.style.spacing.sm
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideMiddle
            font {
                family: Config.style.fonts.mono
                pointSize: 12
            }
        }

        Players.ActiveIcon {
            id: playerIcon
            opacity: .4
            Layout.rightMargin: Config.style.spacing.xs
            Layout.topMargin: Config.style.spacing.xs
        }  

        

        Text {
            text: Players.activePlayer?.trackTitle ?? ''
            color: Config.activeColors.text
            Layout.fillWidth: true
            elide: Text.ElideMiddle
            Layout.preferredHeight: 16
            Layout.bottomMargin: Config.style.spacing.xxs
            Layout.leftMargin: Config.style.spacing.sm
            Layout.rightMargin: Config.style.spacing.xl
            Layout.topMargin: -Config.style.spacing.xs
            Layout.columnSpan: 2
            font {
                family: Config.style.fonts.mono
                pointSize: 16
                weight: 600
            }
        }

        Players.ActiveArt {
            Layout.fillWidth: true
            Layout.columnSpan: 2
        }

    }

}
