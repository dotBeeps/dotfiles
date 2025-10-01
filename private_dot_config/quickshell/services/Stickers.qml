import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton
import qs.util

Singleton {
    id: root

    property alias stickers: stickerData.currentStickers
    property Sticker selectedSticker

    function moveSticker(stickerId: string, region: var) {
        var sticker = stickers.find(s => s.instanceId === stickerId);
        if (sticker) {
            sticker.region = region;
        }
        fileView.writeAdapter()
    }

    FileView {
        id: fileView

        path: `${Paths.config}/.stickers`
        watchChanges: true
        onFileChanged: reload()
        onLoadFailed: (error) => {
            if (error == FileViewError.FileNotFound)
                writeAdapter();

        }

        JsonAdapter {
            id: stickerData

            property list<var> currentStickers

            currentStickers: []
        }

    }

    component Sticker: JsonObject {
        id: sticker

        property string instanceId: {
            crypto.randomUUID();
        }
        property var region: {
            "width": 200,
            "height": 200,
            "x": 0,
            "y": 0
        }
        property bool onTop: false
        property bool locked: false
        required property string screen
        property string source
    }

}
