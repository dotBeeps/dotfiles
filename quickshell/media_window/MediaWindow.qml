import ".."
import "../media"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick.Controls
import Quickshell.Services.Pipewire

FloatingWindow {
    id: root

    property MprisPlayer currentPlayer: Mpris.players.values.find((p) => {
        return p.isPlaying;
    }) || Mpris.players.values.find(p => p.identity === currentPlayer?.identity)

    property PwNodeAudio defaultOutputAudio: Pipewire.defaultAudioSink?.audio
    property PwNodeAudio defaultInputAudio: Pipewire.defaultAudioSource?.audio
    property PwNode defaultOutputNode: Pipewire.defaultAudioSink
    property PwNode defaultInputNode: Pipewire.defaultAudioSource

    color: Config.colors.base

    minimumSize {
        width: 450
        height: layout.implicitHeight
    }

    PwObjectTracker {
        objects: [root.defaultInputNode, root.defaultOutputNode]
    }

    ColumnLayout {
        id: layout

        anchors.fill: parent
        spacing: 8

        MprisInfoFull {
            id: mprisInfo

            Layout.leftMargin: Config.gapLg
            Layout.rightMargin: Config.gapLg
            Layout.topMargin: Config.gapLg
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            player: root.currentPlayer

            ClippingWrapperRectangle {
                id: playerIcon

                radius: 12
                opacity: .4
                anchors {
                    top: mprisInfo.top
                    right: mprisInfo.right
                    margins: 8
                }

                IconImage {
                    implicitSize: 24
                    source: Quickshell.iconPath(root.currentPlayer.desktopEntry)
                }

            }

        }
        

        RowLayout {
                    id: mediaTime
                    Layout.alignment: Qt.AlignTop | Qt.AlignHCenter

                    property var currentTime: root.currentPlayer?.position??0
                    property var endTime: root.currentPlayer?.length??0
                    property var startTime: 0
                    function formatSecMinSec(t) { return `${Math.floor(t / 60)}:${(t % 60).toFixed(0).toString().padStart(2,"0")}` }
                    property string timeStr: formatSecMinSec(currentTime)
                    property string durationStr: formatSecMinSec(root.currentPlayer?.length??0)
                    Layout.leftMargin: Config.gapLg
                    Layout.rightMargin: Config.gapLg
                    implicitHeight: mediaSlider.implicitHeight + 41
                    spacing: Config.gapSm
                    
                    Text {
                        text: mediaTime.timeStr
                        verticalAlignment: Text.AlignVCenter
                        font.family: fontMonofur.name
                        color: Config.colors.text
                    }
                    
                    MediaSlider {
                        id: mediaSlider
                        from: mediaTime.startTime
                        to: mediaTime.endTime
                        value: mediaTime.currentTime
                        onMoved: {
                            if (root.currentPlayer?.canSeek) {
                                root.currentPlayer.position = value
                            }
                        }
                    }

                    Text {
                        text: mediaTime.durationStr
                        verticalAlignment: Text.AlignVCenter
                        font.family: fontMonofur.name
                        color: Config.colors.text
                    }
                    FrameAnimation {
                            running: root.currentPlayer?.playbackState == MprisPlaybackState.Playing
                            onTriggered: root.currentPlayer?.positionChanged()
                        }

                
                }
        
        MprisControls {
            id: controls

            Layout.fillWidth: true
            Layout.topMargin: 2
            Layout.bottomMargin: 4
            Layout.alignment: Qt.AlignHCenter
            pointSize: 20
            player: root.currentPlayer
        }

        RowLayout {
            id: volControls
            Layout.fillWidth: true
            Layout.leftMargin: Config.gapMd
            Layout.rightMargin: Config.gapMd

            TextButton {
                text: root.defaultOutputNode.description.includes('FiiO K5') ? "" : "󰓃"
                font {
                    family: fontMonofur.name
                    pointSize: 40
                }
            }
            Slider {
                id: vol
                Layout.fillWidth: true
                from: 0
                to: 1.5
                enabled: root.defaultOutputAudio
                value: root.defaultOutputAudio.volume || 1
                background: Rectangle {
                    x: vol.leftPadding
                    y: vol.topPadding + vol.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 4
                    color: Config.colors.inactive
                    width: vol.availableWidth
                    height: implicitHeight
                    radius: 2
                    Rectangle {
                        width: vol.visualPosition * parent.width
                        height: parent.height
                        color: Config.colors.urgent
                        radius: 2
                    }
                    Rectangle {
                        x: vol.leftPadding + parent.width * 0.6666 - handle.width/2
                        y: -1.5*parent.height
                        width: 2
                        height: parent.height*4
                        color: Config.colors.urgent
                    }
                }
                handle: Rectangle {
                    id: handle
                    x: vol.leftPadding + vol.visualPosition * (vol.availableWidth - width)
                    y: vol.topPadding + vol.availableHeight / 2 - height / 2
                    implicitHeight: 20
                    implicitWidth: 20
                    radius: 10
                    color: Config.colors.text
                }
                onMoved: {
                    if (Math.abs(value-1) < .025) {
                        value = 1
                    }
                    root.defaultOutputAudio.volume = value
                }
            }
            TextButton {
                text: root.defaultOutputAudio.muted ? '' : root.defaultOutputAudio.volume >= 1 ? "" : root.defaultOutputAudio.volume > 0 ? "" : ""
                font {
                    family: fontMonofur.name
                    pointSize: 40
                }
                onPressed: {
                    root.defaultOutputAudio.muted = !root.defaultOutputAudio.muted
                }
            }
        }

        RowLayout {
            id: micControls
            Layout.fillWidth: true
            Layout.leftMargin: Config.gapMd
            Layout.rightMargin: Config.gapMd

            TextButton {
                text: ""
                font {
                    family: fontMonofur.name
                    pointSize: 40
                }
            }
            Slider {
                id: micVol
                Layout.fillWidth: true
                from: 0
                to: 1.5
                enabled: root.defaultInputAudio
                value: root.defaultInputAudio.volume || 1
                background: Rectangle {
                    x: micVol.leftPadding
                    y: micVol.topPadding + micVol.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 4
                    color: Config.colors.inactive
                    width: micVol.availableWidth
                    height: implicitHeight
                    radius: 2
                    Rectangle {
                        width: micVol.visualPosition * parent.width
                        height: parent.height
                        color: Config.colors.accent
                        radius: 2
                    }
                    Rectangle {
                        x: micVol.leftPadding + parent.width * 0.6666 - micHandle.width/2
                        y: -1.5*parent.height
                        width: 2
                        height: parent.height*4
                        color: Config.colors.accent
                    }
                }
                handle: Rectangle {
                    id: micHandle
                    x: micVol.leftPadding + micVol.visualPosition * (micVol.availableWidth - width)
                    y: micVol.topPadding + micVol.availableHeight / 2 - height / 2
                    implicitHeight: 20
                    implicitWidth: 20
                    radius: 10
                    color: Config.colors.text
                }
                onMoved: {
                    if (Math.abs(value-1) < .025) {
                        value = 1
                    }
                    root.defaultInputAudio.volume = value
                }
            }
            TextButton {
                text: root.defaultInputAudio.muted ? '' : root.defaultInputAudio.volume >= 1 ? "" : root.defaultInputAudio.volume > 0 ? "" : ""
                font {
                    family: fontMonofur.name
                    pointSize: 40
                }
                onPressed: {
                    root.defaultInputAudio.muted = !root.defaultInputAudio.muted
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }

    }

}
