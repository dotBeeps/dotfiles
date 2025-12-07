pragma ComponentBehavior: Bound
import qs.services
import qs.config
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "notification_item"


PanelWindow {
    id: notificationTray
    required property ShellScreen screenData

    property var contentWidth: Math.max(screenData.width * 2 / 7, 800)

    WlrLayershell.layer: WlrLayer.Top
    exclusionMode: ExclusionMode.Ignore
    implicitHeight: screenData.height / 3
    implicitWidth: container.implicitWidth
    screen: screenData
    color: "transparent"

    anchors {
        top: true
    }

    margins {
        top: Config.style.bar.height
    }

    Rectangle {
        id: container

        color: Config.colors.base
        implicitHeight: content.implicitHeight
        implicitWidth: notificationTray.contentWidth
        bottomLeftRadius: 10
        bottomRightRadius: 10
        visible: true
        clip: true

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        ColumnLayout {
            id: content

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            Repeater {
                model: ScriptModel {
                    values: Notifs.notifs.filter(n => n.shown)
                }


            NotificationItem {
                required property Notifs.Notif modelData

                notif: modelData
                            
            }

                    

        }
    }

    Behavior on implicitHeight {
            SmoothedAnimation {
                duration: 750

                easing {
                    type: Easing.OutCubic
                    amplitude: 8
                }

            }
        }

    }

    mask: Region {
        item: container
    }
}


