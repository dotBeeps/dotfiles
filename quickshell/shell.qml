pragma ComponentBehavior: Bound
//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

import QtQuick
import Quickshell
import "bar"
import "notifications"
import "registration"
import "media_window"

Scope {
    id: root

    FontLoader {
        id: iconFont

        source: "fonts/SymbolsNerdFont-Regular.ttf"
    }

    FontLoader {
        id: fontMonofur

        source: "fonts/MonofurNerdFontMono-Regular.ttf"
    }

    Variants {
        model: Quickshell.screens

        Item {
            id: screenItem

            required property ShellScreen modelData

            Bar {
                screenData: screenItem.modelData
            }

            Loader {
                active: screenItem.modelData.name !== 'DP-5'

                sourceComponent: NotificationTray {
                        screenData: screenItem.modelData
                }

            }

            Loader {
                active: screenItem.modelData.name === 'DP-5'
                sourceComponent: Item {
                    MediaWindow {
                        screen: screenItem.modelData
                    }
                }
            }

            Registration {
                screenData: screenItem.modelData
            }

        }

    }

}
