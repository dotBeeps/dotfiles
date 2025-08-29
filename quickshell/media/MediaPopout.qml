import ".."
import "../cava"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import QtQuick.Effects

Item {
    id: root

    required property QsWindow window
    required property MprisPlayer player
    property real offsetX
    property bool popoutShown

    PopupWindow {
        id: popout

        visible: true
        color: "transparent"
        anchor.window: root.window
        anchor.rect.x: root.offsetX 
        anchor.rect.y: root.height
        implicitHeight: bg.implicitHeight
        implicitWidth: root.width 

        Rectangle {
            id: bg

            color: Config.colors.base
            bottomLeftRadius: 24
            bottomRightRadius: 24
            implicitWidth: root.width
            implicitHeight: 1
            visible: false
            clip: true
            transitions: [
                Transition {
                    from: ""
                    to: "visible"

                    SequentialAnimation {
                        PropertyAnimation {
                            target: bg
                            property: "visible"
                            to: true
                            duration: 0
                        }

                        NumberAnimation {
                            target: bg
                            property: "implicitHeight"
                            to: content.implicitHeight
                            easing {
                                type: Easing.OutCubic
                            }
                            duration: 50
                        }

                    }

                },
                Transition {
                    from: "visible"
                    to: ""

                    SequentialAnimation {
                        NumberAnimation {
                            target: bg
                            property: "implicitHeight"
                            easing {
                                type: Easing.OutCubic
                            }
                            to: 1
                            duration: 50
                        }

                        PropertyAnimation {
                            target: bg
                            property: "visible"
                            to: false
                            duration: 0
                        }

                    }

                }
            ]
            states: [
                State {
                    name: "visible"
                    when: root.popoutShown
                },
                State {
                    name: ""
                }
            ]

            ColumnLayout {
                id: content

                width: root.width

                spacing: 8

                anchors {
                    bottom: bg.bottom
                    horizontalCenter: bg.horizontalCenter
                }

                MprisInfoFull {
                    player: root.player
                    Layout.fillWidth: true
                    Layout.leftMargin: Config.gapMd
                    Layout.topMargin: Config.gapMd
                    Layout.rightMargin: Config.gapMd

                }

                RowLayout {
                    id: mediaTime
                    property var currentTime: root.player?.position??0
                    property var endTime: root.player?.length??0
                    property var startTime: 0
                    function formatSecMinSec(t) { return `${Math.floor(t / 60)}:${(t % 60).toFixed(0).toString().padStart(2,"0")}` }
                    property string timeStr: formatSecMinSec(currentTime)
                    property string durationStr: formatSecMinSec(root.player?.length??0)
                    implicitHeight: 120
                    Layout.leftMargin: Config.gapLg
                    Layout.rightMargin: Config.gapLg
                    spacing: Config.gapSm
                    
                    Text {
                        text: mediaTime.timeStr
                        verticalAlignment: Text.AlignVCenter
                        font.family: fontMonofur.name
                        color: Config.colors.text
                    }
                    
                    MediaSlider {
                        id: mediaProgress
                        from: mediaTime.startTime
                        to: mediaTime.endTime
                        value: mediaTime.currentTime
                    }

                    Text {
                        text: mediaTime.durationStr
                        verticalAlignment: Text.AlignVCenter
                        font.family: fontMonofur.name
                        color: Config.colors.text
                    }
                    FrameAnimation {
                            running: root.player?.playbackState == MprisPlaybackState.Playing
                            onTriggered: root.player?.positionChanged()
                        }

                
                }
                

                MprisControls {
                    id: controls

                    Layout.fillWidth: false
                    Layout.topMargin: -Config.gapSm * .5
                    Layout.bottomMargin: Config.gapMd
                    Layout.alignment: Qt.AlignHCenter
                    pointSize: 18
                    player: root.player
                }

            }

            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }

        }
        }

    

}
