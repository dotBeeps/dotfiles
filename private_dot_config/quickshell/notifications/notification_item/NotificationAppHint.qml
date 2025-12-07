import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.config

RowLayout {
    id: root

    required property string appName
    required property string appIcon
    property string iconPath: Quickshell.iconPath(appIcon, true) ?? appIcon

    Text {
        text: root.appName
        color: Config.colors.inactive

        font {
            family: Config.style.fonts.mono
            pointSize: 12
            weight: 100
        }

    }

    IconImage {
        implicitSize: 16
        visible: root.iconPath
        source: root.iconPath
    }

}
