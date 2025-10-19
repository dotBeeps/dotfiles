pragma ComponentBehavior: Bound
//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

import QtQuick
import Quickshell
import Quickshell.Wayland
import "bar"
import "registration"
import "control"
import "notifications"
import qs.config
import qs.modules.sticker
import qs.modules.media


Scope {
    id: root


    StickerWall {
        screen: Quickshell.screens[0]
    }

    Variants {
        model: Quickshell.screens

        Item {
            id: screenItem

            required property ShellScreen modelData

            PanelWindow {
                screen: screenItem.modelData
                WlrLayershell.layer: WlrLayer.Bottom
                WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
                color: Config.activeColors.base.darker(2.5)
                
                anchors {
                    top: true
                    left: true
                    right: true
                    bottom: true
                }
            }

            Loader {
                active: screenItem.modelData.name !== 'sunshine'
                sourceComponent: Item {
                    Bar {
                        screenData: screenItem.modelData
                    }
                    Registration {
                        screenData: screenItem.modelData
                    }
                }
            }

            Loader {
                active: true

                sourceComponent: NotificationTray {
                        screenData: screenItem.modelData
                }

            }

            Loader {
                active: screenItem.modelData.name === 'DP-3'
                sourceComponent: Item {
                    MediaWindow {
                        screen: screenItem.modelData
                    }
                }
            }

        }

    }

}
