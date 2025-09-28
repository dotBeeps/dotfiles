import QtQuick
import QtQuick.Controls

Slider {
    id: root

    property color color: "white"
    property color bg: color.darker(2)
    property list<real> snapPoints: []
    property real snapDivet: .03

    onMoved: {
        value = snapPoints.find(point => Math.abs(point-value) < snapDivet ) ?? value
    }

    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        color: root.bg
        width: root.availableWidth
        height: implicitHeight
        radius: 2

        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            color: root.color
            radius: 2
        }

        Rectangle {
            x: root.leftPadding + parent.width * 0.6666 - sliderHandle.width / 2
            y: -1.5 * parent.height
            width: 2
            height: parent.height * 4
            color: root.color
        }

    }

    handle: Rectangle {
        id: sliderHandle

        x: root.leftPadding + root.visualPosition * (root.availableWidth - width * 0.5)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitHeight: 10
        implicitWidth: 10
        radius: 10
        color: root.color
    }

}
