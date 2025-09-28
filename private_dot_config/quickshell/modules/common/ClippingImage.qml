import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

ClippingWrapperRectangle {
    id: root

    property alias image: image
    property alias source: image.source

    Image {
        id: image

        sourceSize.width: root.Layout.fillWidth ? root.width : 0
        sourceSize.height: root.Layout.fillHeight ? root.height : 0
        asynchronous: true
    }

}
