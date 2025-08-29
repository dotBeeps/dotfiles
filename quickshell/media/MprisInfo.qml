import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Widgets
import ".."

Item {
        id: root
    required property MprisPlayer player
            visible: player


    RowLayout {
        id: content
        spacing: Config.gapSm
        anchors.fill: parent

        ClippingWrapperRectangle {
            Layout.fillHeight: true
            Layout.rightMargin: 4
            Layout.topMargin: 2
            Layout.bottomMargin: 2
            visible: root.player

            radius: 10
            Image {
                id: albumArt
                sourceSize.height: parent.height
                fillMode: Image.PreserveAspectFit
                source: root.player ? root.player.trackArtUrl : ''
            }
        }
        
        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: -1
            Text {
                text: root.player?.trackTitle ?? ''
                color: Config.colors.text
                Layout.preferredHeight: parent.height / 2
                Layout.fillWidth: true
                verticalAlignment: Text.AlignBottom
                elide: Text.ElideMiddle
                font {
                    family: fontMonofur.name
                    weight: 10
                    pointSize: 14
                }
            }

            Text {
                text: root.player?.trackArtist ?? ''
                color: Config.colors.accent
                Layout.preferredHeight: parent.height / 2
                Layout.fillWidth: true
                verticalAlignment: Text.AlignTop
                elide: Text.ElideMiddle
                font {
                    family: fontMonofur.name
                    weight: 10
                    pointSize: 12
                }
            }
        }

    }

}
