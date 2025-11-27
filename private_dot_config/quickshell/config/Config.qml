import Quickshell
import Quickshell.Io
import qs.util
pragma Singleton

Singleton {
    id: root

    property alias colorConfig: settings.colors
    property alias cava: settings.cava
    property alias colors: settings.colors
    property alias notifications: settings.notifications
    property alias primaryScreen: settings.primaryScreen
    property alias loaded: fileView.loaded
    property var activeColors: colors.themes[colors.currentTheme]
    property alias style: settings.style
    property alias gaps: settings.style.spacing
    property alias layerNamespace: settings.layerNamespace
    property alias namespaceNoBlurTag: settings.namespaceNoBlurTag
    readonly property string layerNamespaceNoBlur: layerNamespace + namespaceNoBlurTag

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
