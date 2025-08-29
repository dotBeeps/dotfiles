import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Widgets
import ".."

Item {
        id: root
    required property MprisPlayer player
            visible: player
    implicitHeight: content.implicitHeight

    ColumnLayout {
        id: content
        anchors.horizontalCenter: root.horizontalCenter
        width: root.width

        ClippingWrapperRectangle {
            Layout.fillWidth: true
            radius: 10
            Image {
                id: albumArt
                width: parent.width
                visible: root.player && root.player !== null
                source: root.player ? root.player.trackArtUrl : ''
            }
        }
        
        
        Text {
            text: root.player?.trackTitle ?? ''
            color: Config.colors.text
            Layout.fillWidth: true
            elide: Text.ElideMiddle
            Layout.preferredHeight: 16
            Layout.topMargin: Config.gapSm / 3
            font {
                family: fontMonofur.name
                pointSize: 16
                weight: 600
            }
        }
        Text {
            text: root.player?.trackArtist ?? ''
            color: Config.colors.text
            Layout.fillWidth: true
            elide: Text.ElideMiddle
            font {
                family: fontMonofur.name
                pointSize: 12
            }

        }

    }

}
