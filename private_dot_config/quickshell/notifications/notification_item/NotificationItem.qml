import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.services

Rectangle {
    id: root

    required property Notifs.Notif notif
    readonly property var notification: notif.notification
    readonly property bool hasAppIcon: !!notification.appIcon
    required property int index
    property string mainImage: notification.image ? notification.image : hasAppIcon ? Quickshell.iconPath(notification.appIcon) : ""

    opacity: 0
    color: notiMouseArea.containsMouse ? Config.colors.highlight.alpha(.2) : "transparent"
    Layout.fillWidth: true
    Layout.preferredHeight: notifLayout.implicitHeight
    radius: 10
    states: [
        State {
            name: "visible"
            when: root.notif.visible
        },
        State {
            name: ""
        }
    ]
    transitions: [
        Transition {
            from: ""
            to: "visible"

            OpacityAnimator {
                target: root
                duration: 150
                from: 0
                to: 1

                easing {
                    type: Easing.InQuad
                }

            }

        },
        Transition {
            from: "visible"
            to: ""

            SequentialAnimation {
                OpacityAnimator {
                    target: root
                    duration: 75
                    from: 1
                    to: 0

                    easing {
                        type: Easing.OutQuad
                    }

                }

                ScriptAction {
                    script: root.notif.shown = false
                }

            }

        }
    ]

    MouseArea {
        id: notiMouseArea

        hoverEnabled: true
        anchors.fill: notifLayout
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (mouse) => {
            if (mouse.button == Qt.RightButton)
                root.notification.dismiss();
            else if (mouse.button == Qt.LeftButton && root.notification.actions.length > 0)
                root.notification.actions[0].invoke();
        }
    }

    NotificationAppHint {
        appIcon: root.notification.appIcon
        appName: root.notification.appName

        anchors {
            top: parent.top
            right: parent.right
            topMargin: Config.style.spacing.sm / 2
            rightMargin: Config.style.spacing.sm
        }

    }

    ColumnLayout {
        id: notifLayout

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        NotificationBody {
            notification: root.notification
            mainImage: root.mainImage
            Layout.margins: Config.style.spacing.sm / 2
            Layout.leftMargin: Config.style.spacing.sm
            Layout.rightMargin: Config.style.spacing.sm
            hovered: notiMouseArea.containsMouse
        }

    }

    Behavior on color {
        ColorAnimation {
            duration: 100
        }

    }

}
