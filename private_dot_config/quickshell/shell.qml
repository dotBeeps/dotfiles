pragma ComponentBehavior: Bound
//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

import QtQuick
import Quickshell
import Quickshell.Wayland
import QtQuick.Layouts
import "bar"
import "registration"
import "notifications"
import qs.config
import qs.modules.sticker
import qs.modules.media
import qs.modules.common
import qs.modules.system_state


Scope {
    id: root


    // StickerWall {
    //     screen: Quickshell.screens[0]
    // }

    Variants {
        model: Quickshell.screens

        Item {
            id: screenItem

            required property ShellScreen modelData

            Loader {
                active: screenItem.modelData?.name !== 'sunshine'
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
                active: screenItem.modelData?.name === 'DP-3'
                sourceComponent: Item {
                    MediaWindow {
                        screen: screenItem.modelData
                    }
                }
            }
            
            // SystemStateSwitcher {
            //     screen: screenItem.modelData
            //     actionState: 0
            // }
        }
    }

}
