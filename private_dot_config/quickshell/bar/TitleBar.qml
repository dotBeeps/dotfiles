import qs.config
import QtQuick
import Quickshell.Hyprland
import Quickshell.Widgets

ClippingRectangle {
    id: content
    property var show: {screenItem.modelData.name == Hyprland.focusedMonitor?.name??''}
    implicitHeight: parent.height
    implicitWidth: show ? Math.min(screenItem.modelData.width / 3, titleText.width + 2 * Config.style.spacing.xl) : 0
    visible: width > 5
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    color: "transparent"

    Rectangle {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: 1
        implicitHeight: 0.5 * parent.height
        color: Config.colors.inactive
        opacity: 0.65
    }

    Rectangle {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: 1
        implicitHeight: 0.5 * parent.height
        color: Config.colors.inactive
        opacity: 0.65
    }

    Text {
        id: titleText

        width: Math.min(screenItem.modelData.width / 3 - 2 * Config.style.spacing.xl, implicitWidth)
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: Hyprland.activeToplevel?.wayland?.title ?? Hyprland.activeToplevel?.title ?? "Hi Dot!"
        color: Config.colors.text
        elide: Text.ElideRight
        font.family: Config.style.fonts.mono
        font.pointSize: Config.style.bar.fontSize
        font.weight: 100
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Behavior on implicitWidth {
        SmoothedAnimation {
            velocity: 900
        }

    }

}
