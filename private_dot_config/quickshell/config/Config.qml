import Quickshell
import Quickshell.Io
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

    FileView {
        id: fileView

        path: Quickshell.shellPath('settings.json')
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
