import QtQuick
import Quickshell
import qs.services

Item {
    id: root

    required property ShellScreen screen

    visible: true

    Repeater {
        id: stickerRepeater

        DesktopSticker {
            id: image

            required property var modelData

            sticker: modelData
            screen: root.screen
        }

        model: ScriptModel {
            values: Stickers.stickers.filter((stick) => {
                return stick.screen === root.screen.name;
            })
            objectProp: "instanceId"
        }

    }

}
