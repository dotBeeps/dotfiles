import ".."
import "../cava"
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts

Slider {
    id: mediaProgress

    Layout.fillWidth: true
    implicitHeight: 100

    background: Item {
        id: bgItem

        anchors.fill: mediaProgress

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
            color: Config.colors.inactive
            implicitWidth: bgItem.width
            width: mediaProgress.availableWidth

            Rectangle {
                id: mouseColor

                width: visMouseArea.containsMouse ? visMouseArea.mouseX : width
                height: parent.height
                opacity: visMouseArea.containsMouse ? 0.8 : 0
                color: Config.colors.text

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                    }

                }

            }

            Rectangle {
                id: progressColor

                width: mediaProgress.visualPosition * parent.width
                height: parent.height
                color: Config.colors.accent
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
        x: mediaProgress.visualPosition * parent.width
        y: mediaProgress.topPadding + mediaProgress.availableHeight / 2 - height / 2
        implicitWidth: 2
        implicitHeight: (2 + Cava.values[Math.floor(mediaTime.endTime !== 0 ? (mediaTime.currentTime / mediaTime.endTime) * Cava.values.length : Cava.values.length - 1)] * visualizer.height) * 1.25
        color: Config.colors.highlightAccent
    }

}
