import qs.modules.common
import qs.config
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
pragma ComponentBehavior: Bound

RowLayout {
    id: workspacesLayout

    property var currentWorkspaces: Hyprland.workspaces.values.filter((w) => {
        return w.monitor?.name == bar.screen.name
    })

    property var wsIcons: {
        'godot': '',
        'default': '󱓻',
        'special:communication': ' ',
        'special:music': '󰎄 '
    }

    Repeater {
        model: parent.currentWorkspaces

        TextButton {
            id: control
            required property HyprlandWorkspace modelData
            property string specialIcon: workspacesLayout.wsIcons[modelData.name ?? "default"] || ''
            text: specialIcon  || "󱓻"
            hint: control.modelData.focused
            active: control.modelData.active
            Layout.fillHeight: true
            implicitWidth: 28
            onModelDataChanged: {
                console.log(modelData.name)
                console.log(modelData.active)
                console.log(modelData.focused)
            }
            font {
                family: Config.style.fonts.symbols
                pixelSize: control.modelData.focused || control.hovered ? 24 : control.modelData.active ? 20 : 16
            }

            Behavior on font.pixelSize {
                NumberAnimation {
                    easing {
                        type: Easing.InOutCubic
                    }
                }
            }

            onPressed: () => {
                return modelData.activate();
            }
        }
    }
}
