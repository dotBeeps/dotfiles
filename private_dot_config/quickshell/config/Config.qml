import Quickshell
import Quickshell.Io
import qs.util
pragma Singleton
import QtQuick

Singleton {
    id: root

    property alias colorConfig: settings.colors
    property alias cava: settings.cava
    readonly property alias colorSettings: settings.colors
    property alias notifications: settings.notifications
    property alias primaryScreen: settings.primaryScreen
    property alias loaded: fileView.loaded
    property alias style: settings.style
    property alias gaps: settings.style.spacing
    property alias layerNamespace: settings.layerNamespace
    property alias namespaceNoBlurTag: settings.namespaceNoBlurTag
    readonly property string layerNamespaceNoBlur: layerNamespace + namespaceNoBlurTag

    property var colors: {
        base: "#000000"
        dark: "#000000"
        highlight: "#000000"
        highlightBright: "#000000"
        inactive: "#000000"
        outline: "#000000"
        shadow: "#000000"
        text: "#000000"
        accentPrimary: "#000000"
        accentSecondary: "#000000"
    }

    Component.onCompleted: {
        colors = Qt.binding(() => {
            const colorArr = Object.create(null);
            const currentTheme = colorSettings.themes[colorSettings.currentTheme]
            for (const key in currentTheme) {
                if (key === "objectName" || key.includes('Changed')) {
                    continue;
                }
                const colorName = currentTheme[key]
                colorArr[key] = Qt.color((colorSettings.palettes[colorSettings.currentPalette][colorName] || colorName || "#FFFFFF"))
            }
            return colorArr;
        })
    }

    FileView {
        id: fileView

        path: `${Paths.config}/settings.json`
        watchChanges: true
        onFileChanged: reload()
        onLoadFailed: (error) => {
            if (error == FileViewError.FileNotFound)
                writeAdapter();

        }

        JsonAdapter {
            id: settings

            property Notifications notifications
            property Style style
            property CavaConfig cava
            property string primaryScreen: "DP-2"
            property Colors colors
            property string layerNamespace: "beepshell"
            property string namespaceNoBlurTag: "-noblur"
            cava: CavaConfig {
            }

            colors: Colors {
            }

            notifications: Notifications {
            }

            style: Style {
            }

        }

    }

}
