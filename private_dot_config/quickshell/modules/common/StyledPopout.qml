import QtQml
import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.config

Item {
    id: root

    default property Item child
    property Item anchorItem
    property PopupAnchor.Edges anchorEdge
    property PopupMargins margins
    property bool shown: false
    property QsWindow window
    property color color: Config.activeColors.base

    LazyLoader {
        id: popupLoader

        loading: !!window || !!anchorItem.visible

        PopupWindow {
            id: popup

            property bool shown: root.shown

            visible: false
            implicitWidth: root.implicitWidth || background.implicitWidth
            implicitHeight: root.implicitHeight || background.implicitHeight
            anchor.edges: root.anchorEdge || Edges.Bottom | Edges.Left
            anchor.margins.left: root.margins.left
            anchor.margins.right: root.margins.right
            anchor.margins.top: root.margins.top
            anchor.margins.bottom: root.margins.bottom
            color: "transparent"
            onShownChanged: {
                if (shown)
                    visible = true;

            }
            Component.onCompleted: {
                if (!!root.anchorItem)
                    popup.anchor.item = root.anchorItem;
                else if (!!root.window)
                    popup.anchor.window = root.window;
            }

            WrapperRectangle {
                id: background

                anchors.fill: parent
                color: Config.activeColors.base
                radius: Config.style.rounding.medium
                child: root.child
            }

            ParallelAnimation {
                id: entryAnimation

                running: popup.shown

                ColorAnimation {
                    target: background
                    property: "color"
                    to: root.color
                    duration: 60
                    from: "transparent"
                    easing.type: Easing.InOutQuad
                }

                PropertyAnimation {
                    target: root.margins
                    property: "left"
                    from: -Config.gaps.xxs
                    to: 0
                    duration: 60
                    easing.type: Easing.InOutQuad
                }

            }

            ParallelAnimation {
                id: exitAnimation

                running: !popup.shown
                onRunningChanged: {
                    if (!popup.shown && !running)
                        popup.visible = false;

                }

                ColorAnimation {
                    target: background
                    property: "color"
                    from: root.color
                    duration: 100
                    to: "transparent"
                    easing.type: Easing.InOutQuad
                }

                PropertyAnimation {
                    target: root.margins
                    property: "left"
                    to: Config.gaps.xxs
                    from: 0
                    duration: 100
                    easing.type: Easing.InOutQuad
                }

            }

        }

    }

    margins: PopupMargins {
    }

    component PopupMargins: QtObject {
        property real left: 0
        property real top: 0
        property real right: 0
        property real bottom: 0
    }

}
