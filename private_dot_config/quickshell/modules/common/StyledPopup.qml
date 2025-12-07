pragma ComponentBehavior: Bound
import QtQml
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.config

PopupWindow {
    id: root
    property real hyprOpacity: 1
    property bool shown
    required default property Item child
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight
    color: "transparent"
    property color popupColor
    property real offsetX: 0
    property alias margin: background.margin
    property alias radius: background.radius
    anchor {
        rect {
            x: offsetX
        }
    }
    
    onShownChanged: {
        if (shown)
            visible = true;
    }

    WrapperRectangle {
        id: background

        color: root.popupColor
        radius: Config.style.rounding.medium
        child: root.child
    }

    ParallelAnimation {
        id: entryAnimation

        running: root.shown

        NumberAnimation {
            target: root.HyprlandWindow
            property: "opacity"
            duration: 40
            to: root.hyprOpacity
            easing.type: Easing.OutQuad
        }

        NumberAnimation {
            target: root
            property: "offsetX"
            to: Config.gaps.sm
            duration: 40
            easing.type: Easing.OutQuad
        }
    }

    ParallelAnimation {
        id: exitAnimation

        running: !root.shown
        onRunningChanged: {
            if (!root.shown && !running)
                root.visible = false;
        }

        NumberAnimation {
            target: root.HyprlandWindow
            property: "opacity"
            duration: 40
            to: 0
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: root
            property: "offsetX"
            to: 0
            duration: 40
            easing.type: Easing.InQuad
        }
    }
}
