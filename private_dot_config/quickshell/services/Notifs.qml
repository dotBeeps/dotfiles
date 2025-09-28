import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQml
import qs.config

pragma Singleton

Singleton {
    id: root

    property list<Notif> notifs: []
    readonly property list<Notif> shown: notifs.filter(notif => notif.shown) 

    function hideId(id:int): void {
        const noti = notifs.find(n => n.notification.id === id);
        if (noti) noti.shown = false;
    }

    NotificationServer {
        id: notifServer

        actionIconsSupported: true
        actionsSupported: true
        bodySupported: true
        imageSupported: true
        persistenceSupported: false
        bodyHyperlinksSupported: false
        bodyMarkupSupported: true
        keepOnReload: true
        bodyImagesSupported: true

        onNotification: notif => {
            notif.tracked = true;
            root.notifs.push(notifComponent.createObject(root, {
                shown: true,
                visible: true,
                notification: notif
            }))
        }
    }

    

    component Notif: QtObject {
        id: notif

        property bool shown: false
        property bool visible: false
        readonly property date notifDate: new Date()
        required property Notification notification
        property bool hasAppIcon: notification.appIcon.length > 0
        readonly property string timeFormatted: {
            const diff = Time.clockTime - notifDate.getTime();
            const secs = Math.floor(diff / 1000);
            const mins = Math.floor(secs / 60);
            const hours = Math.floor(mins / 60);
            if (secs < 30)
                return "now";

            if (mins < 1)
                return `${secs} seconds ago`;

            if (hours < 1)
                return `${mins} minutes ago`;

            return `${hours} hours ago`;
        }

        readonly property Timer timer: Timer {
            running: true
            interval: notif.notification.expireTimeout > 0 ? notif.notification.expireTimeout : Config.notifications?.defaults?.timeout ?? 0
            onTriggered: {
                notif.visible = false;
            }
        }

        readonly property RetainableLock lock: RetainableLock {
            object: notif.notification
            locked: notif.shown
        }

        readonly property Connections conn: Connections {
            target: notif.lock

            function onDropped(): void {
                notif.visible = false
            }

            function onAboutToDestroy(): void {
                notif.destroy()
            }
        }
    }

    Component {
        id: notifComponent
        Notif {}
    }
}
