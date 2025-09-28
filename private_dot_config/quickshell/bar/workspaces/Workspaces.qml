import qs.modules.common
import qs.config
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
    id: workspacesLayout

    property var currentWorkspaces: Hyprland.workspaces.values.filter((w) => {
        return w.monitor?.name == bar.screen.name
    })

    Repeater {
        model: parent.currentWorkspaces

        TextButton {
            id: control
            required property HyprlandWorkspace modelData
            text: "󱓻"
            hint: control.modelData.focused
            active: control.modelData.active
            Layout.fillHeight: true
            implicitWidth: 28
            font {
                family: Config.style.fonts.symbols
                pixelSize: control.modelData.focused || control.hovered ? 22 : control.modelData.active ? 18 : 14
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
