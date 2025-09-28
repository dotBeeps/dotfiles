import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.services

Item {
    property alias screen: window.screen
    property alias sticker: rect.sticker

    PanelWindow {
        id: window

        property alias sticker: rect.sticker

        color: "transparent"
        implicitHeight: sticker.region.height
        implicitWidth: sticker.region.width

        anchors {
            top: true
            right: true
            bottom: true
            left: true
        }

        ClippingWrapperRectangle {
            id: rect

            property alias source: image.source
            property alias backer: image
            required property var sticker

            color: "transparent"
            x: sticker.region.x
            y: sticker.region.y

            Image {
                id: image

                sourceSize.height: rect.sticker.region.height
                sourceSize.width: rect.sticker.region.width
                asynchronous: true
                source: rect.sticker.source

                MouseArea {
                    id: mouseArea

                    onReleased: {
                        rect.sticker.region.x = Math.floor(rect.x);
                        rect.sticker.region.y = Math.floor(rect.y);
                        Stickers.moveSticker(rect.sticker.instanceId, rect.sticker.region);
                    }
                    drag.target: rect
                    anchors.fill: parent
                }

            }

        }

        mask: Region {
            item: rect
        }

    }

}
