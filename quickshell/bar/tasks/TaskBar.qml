pragma ComponentBehavior: Bound
import "../.."
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Quickshell

WrapperRectangle {
    id: taskbar

    property var trayItems: SystemTray.items
    required property var barWindow

    color: "transparent"
    radius: Config.bar.radius
    implicitHeight: parent.height

    RowLayout {
        id: buttonRow
        implicitHeight: parent.height

        Repeater {
            model: taskbar.trayItems

            TaskBarButton {
                id: trayButton
                Layout.fillHeight: true
                required property var modelData
                trayItem: modelData
                onPressed: () => {
        var pos = taskbar.barWindow.mapFromItem(trayButton, implicitWidth / 2, implicitHeight);
        modelData.display(taskbar.barWindow, pos.x, pos.y);
    }
            }

                

        }

    }

}
