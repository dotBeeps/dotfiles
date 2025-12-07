import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services

Item {
    id: root

    visible: !!Players.activePlayer

    RowLayout {
        id: content

        spacing: Config.style.spacing.sm
        anchors.fill: parent

        Players.ActiveArt {
            Layout.fillHeight: true
            Layout.rightMargin: 4
            Layout.topMargin: 2
            Layout.bottomMargin: 2
            radius: 10
        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: -1

            Text {
                text: Players.activePlayer.trackTitle ?? ''
                color: Config.colors.text
                Layout.preferredHeight: parent.height / 2
                Layout.fillWidth: true
                verticalAlignment: Text.AlignBottom
                elide: Text.ElideMiddle

                font {
                    family: Config.style.fonts.mono
                    weight: 10
                    pointSize: 14
                }

            }

            Text {
                text: Players.activePlayer.trackArtist ?? ''
                color: Config.colors.accent
                Layout.preferredHeight: parent.height / 2
                Layout.fillWidth: true
                verticalAlignment: Text.AlignTop
                elide: Text.ElideMiddle

                font {
                    family: Config.style.fonts.mono
                    weight: 10
                    pointSize: 12
                }

            }

        }

    }

}
