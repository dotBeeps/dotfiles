import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import qs.config
import qs.modules.cava
import qs.services

Slider {
    id: root

    Layout.fillWidth: true
    implicitHeight: 100

    background: Item {
        id: bgItem

        anchors.fill: root

        CavaVisualizer {
            id: visualizer

            anchors.fill: parent
            layer.enabled: true
            visible: false
        }

        Rectangle {
            id: colors

            visible: false
            anchors.fill: visualizer
            color: Config.activeColors.inactive
            implicitWidth: bgItem.width
            width: root.availableWidth

            Rectangle {
                id: mouseColor

                width: visMouseArea.containsMouse ? visMouseArea.mouseX : width
                height: parent.height
                opacity: visMouseArea.containsMouse ? 0.8 : 0
                color: Config.activeColors.text

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                    }

                }

            }

            Rectangle {
                id: progressColor

                width: root.visualPosition * parent.width
                height: parent.height
                color: Config.activeColors.accent
            }

        }

        MouseArea {
            id: visMouseArea

            anchors.fill: parent
            hoverEnabled: true
        }

        MultiEffect {
            source: colors
            anchors.fill: colors
            maskEnabled: true
            maskSource: visualizer
        }

    }

    handle: Rectangle {
        x: root.visualPosition * parent.width
        y: root.topPadding + root.availableHeight / 2 - height / 2
        visible: !!Cava.values
        implicitWidth: 2
        implicitHeight: Cava.values ? (2 + Cava.values[Math.floor(root.to !== 0 ? (root.value / root.to) * Cava.values.length : Cava.values.length - 1)] * visualizer.height) * 1.25 : 0
        color: Config.activeColors.highlightAccent
    }

}
