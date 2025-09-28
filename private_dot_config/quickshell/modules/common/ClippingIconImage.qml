import Quickshell.Widgets

ClippingRectangle {
    id: root

    property real implicitSize
    property alias iconImage: icon
    property alias source: icon.source

    implicitHeight: implicitSize
    implicitWidth: implicitSize

    IconImage {
        id: icon

        anchors.fill: parent
    }

}
