import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.modules.media
import qs.modules.media.mediaInfo
import qs.services

Item {
    id: root

    property real offsetX
    property bool popoutShown

    PopupWindow {
        id: popout

        visible: true
        color: "transparent"
        anchor.window: QsWindow.window
        anchor.rect.x: root.offsetX
        anchor.rect.y: root.height
        implicitHeight: bg.implicitHeight
        implicitWidth: root.width

        Rectangle {
            id: bg

            color: Config.activeColors.dark
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
                            duration: 50

                            easing {
                                type: Easing.OutCubic
                            }

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
                            to: 1
                            duration: 50

                            easing {
                                type: Easing.OutCubic
                            }

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

                MediaInfo {
                    Layout.fillWidth: true
                    Layout.leftMargin: Config.style.spacing.sm
                    Layout.topMargin: Config.style.spacing.sm
                    Layout.rightMargin: Config.style.spacing.sm
                }

                MediaSliderPanel {
                }

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

}
