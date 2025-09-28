import QtQuick
import Quickshell.Widgets
import qs.config

WrapperItem {
    id: root

    property alias active: loader.active

    Loader {
        id: loader

        anchors.fill: parent

        sourceComponent: ClippingWrapperRectangle {
            color: Config.activeColors.base.darker(1.5).alpha(0.9)
            radius: Config.style.rounding.small

            MediaInfo {
                id: mprisInfo

                anchors.fill: parent
            }

        }

    }

}
