import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.config
import qs.services
import qs.modules.media

WrapperItem {
    id: root

    ColumnLayout {
        id: content

        spacing: Config.gaps.xs

        RowLayout {
            id: playingInfo
            Layout.fillWidth: true
            // Layout.bottomMargin: Config.style.spacing.xxs
                        
            ColumnLayout {
                id: playingInfoText
                Layout.leftMargin: Config.gaps.xxs
                Text {
                    text: Players.activePlayer?.trackArtist ?? ''
                    color: Config.activeColors.text
                    Layout.fillWidth: true
                    Layout.bottomMargin: -Config.gaps.xxs
                    elide: Text.ElideMiddle
                    verticalAlignment: Text.Bottom
                    visible: text !== ''
                    font {
                        family: Config.style.fonts.mono
                        pointSize: 12
                    }
                }

                Text {
                    text: Players.activePlayer?.trackTitle ?? ''
                    color: Config.activeColors.text
                    Layout.fillWidth: true
                    elide: Text.ElideMiddle
                    verticalAlignment: Text.Top
                    // Layout.preferredHeight: 16
                    font {
                        family: Config.style.fonts.mono
                        pointSize: 16
                        weight: 600
                    }
                }
            }

            Players.ActiveIcon {
                id: playerIcon
                opacity: .4
                Layout.fillHeight: true
                Layout.margins: Config.style.spacing.xxs
                implicitWidth: height
            }  

        }

        


        Players.ActiveArt {
            radius: Config.style.rounding.small
            Layout.fillWidth: true
        }

    }

}
