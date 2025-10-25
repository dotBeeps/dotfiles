import QtQml
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.config

Item {
    id: root

    property bool shown
    default property QtObject children
    property ShellScreen screen
    property Margins margins
    property Margins implicitMargins
    property Anchor anchor

    LazyLoader {
        id: popupLoader

        loading: true

        component: PanelPopupWindow {
            visible: root.shown
            child: root.children
            screen: root.screen

            anchors {
                top: root.anchor.top
                right: root.anchor.right
                bottom: root.anchor.bottom
                left: root.anchor.left
            }

            margins {
                top: root.implicitMargins.top
                right: root.implicitMargins.right
                bottom: root.implicitMargins.bottom
                left: root.implicitMargins.left
            }

        }

    }

    margins: Margins {
    }

    implicitMargins: Margins {
        top: margins.top
        bottom: margins.bottom
        right: margins.right
        left: margins.left
    }

    anchor: Anchor {
    }

    component Margins: QtObject {
        property double top: 0
        property double right: 0
        property double bottom: 0
        property double left: 0
    }

    component Anchor: QtObject {
        property bool top: false
        property bool right: false
        property bool bottom: false
        property bool left: false
    }

    component PanelPopupWindow: PanelWindow {
        id: panelWindow

        property alias child: background.data

        implicitWidth: background.implicitWidth
        implicitHeight: background.implicitHeight
        color: "transparent"

        WrapperRectangle {
            id: background

            //anchors.fill: parent
            color: Config.activeColors.base
            radius: Config.style.rounding.medium
        }

    }

}
