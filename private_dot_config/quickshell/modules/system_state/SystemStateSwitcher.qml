import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.services
import qs.util

PanelWindow {
    id: statePanel

    enum SystemStateChange {
        Hidden = 0,
        Gamemode = 1,
        Suspend = 2,
        Restart = 3,
        PowerOff = 4
    }

    property var states: [{
        "open": false,
        "text": "",
        "icon": "",
        "color": "transparent"
    }, {
        "open": true,
        "icon": "󰊴",
        "text": "gamemode?",
        "color": Config.colors.accentSecondary.alpha(0.9),
        "command": "gamescope steam"
    }, {
        "open": true,
        "icon": "󰤄",
        "text": "suspend?",
        "color": Config.colors.base.alpha(0.9),
        "command": "echo 'suspend'"
    }, {
        "open": true,
        "icon": "󰜉",
        "text": "restart?",
        "color": Config.colors.accentSecondary.alpha(0.9),
        "command": "echo 'restart'"
    }, {
        "open": true,
        "icon": "󰐥",
        "text": "power off?",
        "color": Config.colors.accent.alpha(0.9),
        "command": "poweroff"
    }]
    property real actionState: 0
    property bool executing: false
    readonly property var currentState: states[actionState]

    property bool bindHeld: false

    exclusionMode: ExclusionMode.Ignore
    color: "transparent"

    Timer {
        id: stateChangeTimeout
        interval: 800
        running: false
        repeat: false
    }

    Timer {
        id: hideTimer
        interval: 3000
        running: false
        repeat: false

        onTriggered: {
            statePanel.actionState = 0;
            statePanel.executing = false;
        }
    }

    anchors {
        top: true
        right: true
        left: true
        bottom: true
    }

    BeepShellHyprShortcut {
        description: "Power off press handler"
        name: "power-press"
        onPressed: {
            statePanel.executing = true;            
            switch (statePanel.actionState) {
                case 0:
                    SystemState.suspend();
                    break;
                case 1:
                    SystemState.bigPicture();
                    break;
                case 2:
                    SystemState.suspend();                    
                    break;
                case 3:
                    SystemState.restart();
                    break;
                case 4:
                    SystemState.poweroff();
                    break;
                default:
                    break;
            }
            hideTimer.restart();
            stateChangeTimeout.restart();
        }
    }
    
    BeepShellHyprShortcut {
        description: "Power off release handler"
        name: "power-release"
        onReleased: {
            if (!stateChangeTimeout.running) {    
                if (statePanel.actionState >= 4) {
                    statePanel.actionState = 0;
                    hideTimer.stop();
                    stateChangeTimeout.start();
                } else {
                    statePanel.actionState = statePanel.actionState + 1;
                    hideTimer.restart();
                }
            }
        }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        bottomLeftRadius: Config.style.rounding.xl
        bottomRightRadius: Config.style.rounding.xl
        color: statePanel.currentState.color
        implicitHeight: statePanel.currentState.open ? (col.implicitHeight + col.anchors.topMargin + Config.gaps.xxl) : 100
        clip: true

        Behavior on implicitHeight {
            NumberAnimation {
                duration: 200
                onRunningChanged: {
                    if (!running && statePanel.executing && statePanel.actionState === 0) {
                        statePanel.executing = false;
                    } 
                }
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: 400
            }
        }

        Rectangle {
            id: progress

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom

            implicitWidth: statePanel.executing ? parent.width : 0

            color: Config.colors.base.alpha(.10)

            bottomLeftRadius: Config.style.rounding.xl
            bottomRightRadius: Config.style.rounding.xl

            NumberAnimation {
                target: progress
                property: "implicitWidth"
                duration: 1000
                easing.type: Easing.InOutQuad

                onFinished: {
                    performAction()
                }
            }
        }

        ColumnLayout {
            id: col

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: Config.gaps.xxl * 2
            spacing: Config.gaps.md
            Text {
                text: statePanel.currentState.icon
                color: "white"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                font.family: Config.style.fonts.symbols
                font.pixelSize: Config.style.fonts.ptXxxl * 4
                verticalAlignment: Text.AlignTop
                padding: 0
            }

            Text {
                text: statePanel.currentState.text
                color: "white"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                font.family: Config.style.fonts.mono
                font.pixelSize: Config.style.fonts.ptXxxl
                Layout.topMargin: -Config.gaps.sm
            }

        }

    }

    mask: Region {
    }

}
