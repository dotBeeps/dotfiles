import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.config
import qs.modules.audio
import qs.modules.common
import qs.modules.media
import qs.modules.media.mediaInfo
import qs.services

PanelWindow {
    id: controlCenter

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    GridLayout {
        id: layout

        anchors.fill: parent
        anchors.topMargin: Config.style.spacing.sm
        uniformCellWidths: true
        columns: 2
        columnSpacing: 0
        rowSpacing: 0

        WrapperRectangle {
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            Layout.leftMargin: Config.style.spacing.md
            Layout.rightMargin: Config.style.spacing.md
            color: "transparent"
            radius: Config.style.rounding.medium
            margin: Config.style.spacing.sm

            border {
                width: 2
                color: Config.activeColors.outline.alpha(0.4)
            }

            Text {
                id: clock

                text: `${Time.shortDate}\n${Time.time}`
                color: Config.activeColors.text.darker(1.25)
                horizontalAlignment: Text.AlignHCenter

                font {
                    family: Config.style.fonts.mono
                    pointSize: Config.style.fonts.ptMd
                }

            }

        }

        Item {
            Layout.fillWidth: true
            Layout.leftMargin: Config.style.spacing.xxl
            Layout.rightMargin: Config.style.spacing.md
            Layout.alignment: Qt.AlignTop
            implicitHeight: clock.implicitHeight

            StyledProgress {
                id: phoneBattery

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: Config.style.spacing.xxs
                implicitWidth: parent.width
                color: Config.activeColors.accent
                progress: KdeConnect.chargeLevel
                implicitHeight: 20
                text: `${KdeConnect.chargeLevel*100}${KdeConnect.isCharging ? ' ' : ''}`
            }

        }

        MediaInfoPanel {
            active: !!Players.activePlayer
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
        }

        MediaSliderPanel {
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.fillWidth: true
        }

        Rectangle {
            id: controlWrapper

            Layout.fillWidth: true
            Layout.columnSpan: 2
            radius: 8
            color: Config.activeColors.base.darker(1.5).alpha(0.9)
            implicitHeight: controlColumn.implicitHeight

            Item {
                id: mediaControls

                anchors.fill: parent

                ColumnLayout {
                    id: controlColumn

                    anchors.horizontalCenter: parent.horizontalCenter
                    width: controlWrapper.width

                    MprisControls {
                        id: controls

                        Layout.fillWidth: true
                        Layout.topMargin: Config.style.spacing.md
                        pointSize: 20
                        Layout.alignment: Qt.AlignHCenter
                        player: Players.activePlayer
                        visible: !!Players.activePlayer
                    }

                    Loader {
                        active: !!Audio.defaultSink
                        Layout.fillWidth: true
                        Layout.leftMargin: Config.style.spacing.xs
                        Layout.topMargin: Config.style.spacing.xs
                        Layout.rightMargin: Config.style.spacing.xs

                        sourceComponent: VolumeControl {
                            id: volControls

                            anchors.fill: parent
                            iconButton.text: "󰓃"
                            iconButton.font.pointSize: Config.style.fonts.ptMd
                            slider.value: Audio.volume
                            slider.color: Config.activeColors.urgent
                            slider.onMoved: {
                                Audio.setVolume(slider.value);
                            }
                        }

                    }

                    Loader {
                        active: !!Audio.defaultSource
                        Layout.fillWidth: true
                        Layout.leftMargin: Config.style.spacing.xs
                        Layout.rightMargin: Config.style.spacing.xs
                        Layout.bottomMargin: Config.style.spacing.xs - 1

                        sourceComponent: VolumeControl {
                            id: micControls

                            anchors.fill: parent
                            iconButton.text: ""
                            iconButton.font.pointSize: Config.style.fonts.ptLg
                            slider.value: Audio.sourceVolume
                            slider.color: Config.activeColors.accent
                            slider.onMoved: {
                                Audio.setSourceVolume(slider.value);
                            }
                        }

                    }

                }

            }

        }

        Item {
            Layout.columnSpan: 2
            Layout.fillHeight: true
        }

    }

}
