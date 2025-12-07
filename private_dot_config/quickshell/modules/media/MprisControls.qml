import qs.config
import qs.modules.common
import QtQuick.Layouts
import Quickshell.Services.Mpris
import QtQuick
import Quickshell.Widgets
import Quickshell

Rectangle {
    id: root
    required property MprisPlayer player
    property real pointSize: 14
    color: 'transparent'        
    implicitHeight: layout.height + Config.gaps.md

    RowLayout {
        id: layout
        spacing: Config.style.spacing.sm
        anchors.centerIn: parent

        
        TextButton {
            text: root.player?.shuffle ? "" : "󰒞"
            visible: !!root.player?.shuffleSupported
            font {
                pointSize: root.pointSize
            }
            implicitWidth: root.pointSize *1.25
            hoverEnabled: root.player?.shuffleSupported
            color: hoverEnabled ? hovered ? Config.colors.accent : Config.colors.text : Config.colors.inactive
            onClicked: () => {
                if (root.player?.shuffleSupported)
                    root.player.shuffle = !root.player.shuffle
            }   
        }

        TextButton {
            text: "󰕇"
            font {
                pointSize: root.pointSize
            }
            implicitWidth: root.pointSize *1.25
            hoverEnabled: !!root.player?.loopSupported
            visible: !!root.player?.loopSupported
            color: hoverEnabled ? root.player.loopState !== MprisLoopState.None || hovered ? Config.colors.accent : Config.colors.text : Config.colors.inactive
            onClicked: () => {
                if (root.player?.loopSupported)
                    root.player.loopState = root.player.loopState === MprisLoopState.None ? MprisLoopState.Track : MprisLoopState.None
            }   
        }

        Item {
            visible: root.player?.shuffleSupported || !!root.player?.loopSupported
            implicitWidth: Config.style.spacing.sm
        }

        TextButton {
            text: ""
            font {
                pointSize: root.pointSize
            }
            implicitWidth: root.pointSize *1.25
            hoverEnabled: root.player?.canGoPrevious
            color: hoverEnabled ? hovered ? Config.colors.accent : Config.colors.text : Config.colors.inactive
        
            onClicked: () => {
                if (root.player?.canGoPrevious)
                    root.player.previous();

            }   
        }

            TextButton {
                text: ""
                font {
                    pointSize: root.pointSize
                }
                hoverEnabled: root.player?.canControl
                implicitWidth: root.pointSize*1.25
            
                color: hoverEnabled ? hovered ? Config.colors.accent : Config.colors.text : Config.colors.inactive
                onClicked: () => {
                    if (root.player?.canControl)
                        root.player.stop();

                }
            }

            TextButton {
                text: root.player?.isPlaying ? "" : ""
            
                font {
                    pointSize: root.pointSize
                }
                implicitWidth: root.pointSize*1.25
                hoverEnabled: root.player?.canPause || root.player?.canPlay
                color: hoverEnabled ? hovered ? Config.colors.accent : Config.colors.text : Config.colors.inactive
                onPressed: () => {
                    if (root.player?.isPlaying && root.player?.canPause)
                        root.player.pause();
                    else if (root.player?.canPlay)
                        root.player.play();
                }
            }

            TextButton {
                text: ""
                font {
                    pointSize: root.pointSize
                }
                implicitWidth: root.pointSize*1.25
                hoverEnabled: root.player?.canGoNext
                color: hoverEnabled ? hovered ? Config.colors.accent : Config.colors.text : Config.colors.inactive
                onClicked: () => {
                    if (root.player?.canGoNext)
                        root.player.next();

                }
            }

    }
}

