import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.config
import qs.modules.bar
import "tasks"

PanelWindow {
    id: bar

    required property ShellScreen screenData

    screen: screenData
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    color: "transparent"
    implicitHeight: barShape.height
    exclusiveZone: Config.style.bar.height

    anchors {
        top: true
        left: true
        right: true
    }

    Shape {
        id: barShape

        opacity: 1

        ShapePath {
            strokeColor: "transparent"
            startX: 0
            startY: 0

            PathLine {
                x: bar.width
                y: 0
            }

            PathLine {
                x: bar.width
                y: Config.style.bar.height + Config.style.bar.radius
            }

            PathArc {
                x: bar.width - Config.style.bar.radius
                y: Config.style.bar.height
                radiusX: Config.style.bar.radius
                radiusY: Config.style.bar.radius
                direction: PathArc.Counterclockwise
            }

            PathLine {
                x: Config.style.bar.radius
                y: Config.style.bar.height
            }

            PathArc {
                x: 0
                y: Config.style.bar.height + Config.style.bar.radius
                radiusX: Config.style.bar.radius
                radiusY: Config.style.bar.radius
                direction: PathArc.Counterclockwise
            }

            PathLine {
                x: 0
                y: 0
            }

            fillGradient: LinearGradient {
                x1: 0
                x2: 0
                y1: 0
                y2: barShape.height

                GradientStop {
                    position: 0
                    color: Config.activeColors.base
                }

                GradientStop {
                    position: 0.55
                    color: Config.activeColors.base
                }

                GradientStop {
                    position: 0.75
                    color: "#f011171d"
                }

            }

        }

    }

    WrapperItem {
        id: barContainer

        anchors.horizontalCenter: parent.horizontalCenter

        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 4
            implicitWidth: bar.width - Config.style.spacing.sm
            implicitHeight: Config.style.bar.height

            RowLayout {
                anchors.verticalCenter: parent.verticalCenter
                implicitHeight: parent.height
                spacing: Config.style.spacing.sm

                OsWorkspaceBar {
                    leftMargin: Config.style.spacing.sm
                }

                Rectangle {
                    implicitHeight: parent.height * 0.75
                    implicitWidth: 1
                    color: Config.activeColors.text
                    opacity: 0.65
                    Layout.rightMargin: 10
                }

                BarPlayerInfo {
                    Layout.fillHeight: true
                    Layout.maximumWidth: 800
                    Layout.preferredWidth: 380
                    Layout.fillWidth: true
                }

            }

            TitleBar {
            }

            RowLayout {
                anchors.right: parent.right
                height: parent.height

                TaskBar {
                    visible: Config.primaryScreen === bar.screenData.name ?? ''
                    barWindow: bar
                }

                ClockBar {
                }

            }

        }

    }

}
