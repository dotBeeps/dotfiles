import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.modules.common

BeepsPanelWindow {
    id: register
    blur: false
    
    required property ShellScreen screenData
    property var possibleMessages: [["Activate 󰩃  Linux", "Go to Settings to activate 󰩃  Linux."], ["Deactivate 󰩃  Linux", "Why would you activate it?", "What does that even mean?"], ["Activate Lesbian 󰩃  Linux", "Become Sapphic to activate Lesbian 󰩃  Linux."], ["Unregistered HyperCam 2"], ["Pass the Activatema", "What?", "Go to Settings to activatema 󰩃  Linux lmaoooo."]]
    property var currentMessages: possibleMessages[Math.floor(Math.random() * possibleMessages.length)]

    color: "transparent"
    WlrLayershell.layer: WlrLayer.Overlay
    implicitHeight: content.height
    implicitWidth: content.width
    screen: screenData

    anchors {
        right: true
        bottom: true
    }

    margins {
        right: 50
        bottom: 50
    }

    Timer {
        interval: 60000 * 5
        running: true
        repeat: true
        onTriggered: register.currentMessages = register.possibleMessages[Math.floor(Math.random() * register.possibleMessages.length)]
    }

    ColumnLayout {
        id: content

        Repeater {
            model: register.currentMessages

            Text {
                required property var modelData
                required property int index

                text: modelData
                color: Config.colors.highlight
                font.pointSize: index == 0 ? Config.style.fonts.pointSizeBase + 2 : Config.style.fonts.pointSizeBase
            }

        }

    }

    mask: Region {
    }

}
