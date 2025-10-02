import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import qs.config

Button {
    id: control

    property alias source: img.source

    flat: true
    display: AbstractButton.TextOnly
    implicitHeight: control.height
    implicitWidth: control.height - Config.style.spacing.sm
    hoverEnabled: true

    Image {
        id: img

        anchors.centerIn: parent
        height: control.height - Config.style.spacing.md
        width: control.height - Config.style.spacing.md
    }

}
