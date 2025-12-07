pragma ComponentBehavior: Bound
import qs.modules.common
import qs.config
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell

RowLayout {
    id: workspacesLayout
    property list<string> activeSpecial: ['','']
    property var currentWorkspaces: Hyprland.workspaces.values.filter(w => {
        return w.monitor?.name === QsWindow.window.screen.name && !w.name.includes('special');
    })

    property var specialWorkspaces: Hyprland.workspaces.values.filter(w => w.name.includes('special:'))

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activespecial") {
                workspacesLayout.activeSpecial = event.parse(2)
                if (workspacesLayout.activeSpecial[0] === "special:discord") {
                    Hyprland.dispatch("resizewindowpixel exact 80% 80%,class:vesktop|equibop|discord")
                    Hyprland.dispatch("focuswindow class:vesktop|equibop|discord")
                    Hyprland.dispatch("centerwindow")
                }
            }
        }
    }

    property var wsIcons: {
        'godot': '',
        'default': '󱓻',
        'special:discord': ' ',
        'special:music': '󰎄 '
    }

    Repeater {
        model: parent.currentWorkspaces

        TextButton {
            id: control
            required property HyprlandWorkspace modelData
            property string specialIcon: workspacesLayout.wsIcons[modelData.name ?? "default"] || ''
            text: specialIcon || "󱓻"
            hint: control.modelData.focused
            active: control.modelData.active
            Layout.fillHeight: true
            implicitWidth: 28
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

    Rectangle {
        Layout.fillHeight: true
        implicitWidth: 1
        color: Config.colors.highlight
        Layout.margins: Config.gaps.sm
        Layout.topMargin: Config.gaps.xs
        Layout.bottomMargin: Config.gaps.xs
    }
    
    Repeater {
        model: parent.specialWorkspaces

        TextButton {
            id: specialControl
            required property HyprlandWorkspace modelData
            property string specialIcon: workspacesLayout.wsIcons[modelData.name ?? 'default'] || ''
            property bool isActive: modelData.name === workspacesLayout.activeSpecial[0]
            property bool onMonitor: workspacesLayout.activeSpecial[1] === QsWindow.window?.screen?.name
            active: isActive
            text: specialIcon
            Layout.fillHeight: true
            implicitWidth: 28
            
            font {
                family: Config.style.fonts.symbols
                pixelSize: specialControl.isActive && specialControl.onMonitor ? 20 : specialControl.hovered ? 20 : 16
            }
            onPressed: () => {
                console.log(modelData.id, modelData.name, modelData.focused, modelData.active, modelData.monitor, Hyprland.focusedMonitor.name, Hyprland.focusedMonitor.activeWorkspace.name);
            }
        }
    }
}
