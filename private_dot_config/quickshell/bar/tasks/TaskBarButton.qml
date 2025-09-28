import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import qs.config

Button {
    id: control

    required property SystemTrayItem trayItem
    property var iconOrDefaultSource: {
        control.trayItem.icon.startsWith('image://icon/') ? Quickshell.iconPath(control.trayItem.icon.slice(13, control.trayItem.icon.indexOf('?') >= 0 ? control.trayItem.icon.indexOf('?') : undefined), 'view-grid') : control.trayItem.icon;
    }

    flat: true
    display: AbstractButton.TextOnly
    implicitHeight: control.height
    implicitWidth: control.height - Config.style.spacing.sm
    hoverEnabled: true

    Image {
        anchors.centerIn: parent
        source: control.iconOrDefaultSource
        height: control.height - Config.style.spacing.md
        width: control.height - Config.style.spacing.md
    }

}
