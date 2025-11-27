pragma ComponentBehavior: Bound
import QtQml
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.config

Item {
    id: root

    default property Item child
    property Item anchorItem
    property Edges anchorEdge
    property PopupMargins margins
    property PopupMargins implicitMargins
    property bool shown: false
    property QsWindow window
    property color color: Config.activeColors.base
    property real hyprOpacity: 1

    onMarginsChanged: {
        implicitMargins.top = margins.top;
        implicitMargins.bottom = margins.bottom;
        implicitMargins.right = margins.right;
        implicitMargins.left = margins.left;
    }

    LazyLoader {
        id: popupLoader

        loading: !!root.window || !!root.anchorItem.visible

        PopupWindow {
            id: popup
            HyprlandWindow.opacity: root.hyprOpacity
            property bool shown: root.shown
            visible: false
            implicitWidth: root.implicitWidth || background.implicitWidth
            implicitHeight: root.implicitHeight || background.implicitHeight
            anchor.edges: root.anchorEdge || Edges.Bottom | Edges.Left
            anchor.margins.left: root.implicitMargins.left
            anchor.margins.right: root.implicitMargins.right
            anchor.margins.top: root.implicitMargins.top
            anchor.margins.bottom: root.implicitMargins.bottom
            anchor.window: root.window
            anchor.item: root.anchorItem
            color: "transparent"
            onShownChanged: {
                if (shown)
                    visible = true;

            }

            WrapperRectangle {
                id: background

                anchors.fill: parent
                color: root.color
                radius: Config.style.rounding.medium
                child: root.child
            }

            ParallelAnimation {
                id: entryAnimation

                running: popup.shown

                NumberAnimation {
                    target: popup.HyprlandWindow
                    property: "opacity"
                    from: 0
                    duration: 40
                    to: root.hyprOpacity
                    easing.type: Easing.OutQuad
                }

                NumberAnimation {
                    target: root.implicitMargins
                    property: "bottom"
                    from: -root.margins.bottom
                    to: root.margins.bottom
                    duration: 40
                    easing.type: Easing.OutQuad
                }

            }

            ParallelAnimation {
                id: exitAnimation

                running: !popup.shown
                onRunningChanged: {
                    if (!popup.shown && !running)
                        popup.visible = false;

                }

                NumberAnimation {
                    target: popup.HyprlandWindow
                    property: "opacity"
                    from: root.hyprOpacity
                    duration: 40
                    to: 0
                    easing.type: Easing.InOutQuad
                }

                NumberAnimation {
                    target: root.implicitMargins
                    property: "bottom"
                    to: -root.margins.bottom
                    duration: 40
                    easing.type: Easing.InQuad
                }

            }

        }

    }

    margins: PopupMargins {
    }

    implicitMargins: PopupMargins {
    }

    component PopupMargins: QtObject {
        property real left: 0
        property real top: 0
        property real right: 0
        property real bottom: 0
    }

}
