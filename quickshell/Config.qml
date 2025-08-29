import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property var colors: themes[themes[settings.currentTheme] == null ? 'default' : settings.currentTheme]
    property var themes: {
        "default": {
            "base": "#FC20272f",
            "shadow": "#232230",
            "highlight": "#2b3b4a",
            "urgent": "#e087b4",
            "accent": "#86cecb",
            "highlightAccent": "#a1f9f5",
            "text": "#e7edf2",
            "highlightOverlay": "#10e7edf2",
            "outline": "#d9dee2",
            "inactive": "#a0d9dee2"
        }
    }
    property alias settings: settingsJsonAdapter.settings
    property var gapSm: settings.gapSm
    property var gapMd: settings.gapMd
    property var gapLg: settings.gapLg
    property var gapXl: settings.gapXl
    property var primaryScreen: settings.primaryScreen
    property var bar: settings.bar
    property var notifications: settings.notifications
    property var notifConfig: notifications.notifConfig[notifications.notifConfig[notifications.currentConfig] == null ? 'default' : notifications.currentConfig]
    property var cava: settings.cava

    FileView {
        path: Qt.resolvedUrl("./settings.json")
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()
        onLoadFailed: (error) => {
            if (error == FileViewError.FileNotFound)
                writeAdapter();

        }

        JsonAdapter {
            id: settingsJsonAdapter

            property var settings: {
                "currentTheme": "default",
                "gapSm": 14,
                "gapMd": 22,
                "gapLg": 32,
                "gapXl": 46,
                "primaryScreen": "DP-2",
                "notifications": {
                    "defaultTimeout": 5000,
                    "currentConfig": "default",
                    "notifConfig": {
                        "default": {
                            "default": {
                                "appHint": {
                                    "show": true,
                                    "icon": "app"
                                }
                            },
                            "equicord": {
                                "appHint": {
                                    "show": true,
                                    "icon": "app"
                                }
                            }
                        }
                    }
                },
                "bar": {
                    "height": 50,
                    "fontSize": 16,
                    "opacity": 0.9,
                    "radius": 20
                },
                "cava": {
                    "general": {
                        "bars": 22,
                        "framerate": 60,
                        "autosens": 1,
                        "sensitivity": 100,
                        "lower_cutoff_freq": 50,
                        "higher_cutoff_freq": 12000
                    },
                    "smoothing": {
                        "monstercat": 0,
                        "noise_reduction": 40
                    },
                    "output": {
                        "method": "raw",
                        "data_format": "ascii",
                        "ascii_max_range": 100,
                        "bit_format": "8bit",
                        "channels": "mono",
                        "mono_option": "average"
                    }
                }
            }
        }

    }

}
