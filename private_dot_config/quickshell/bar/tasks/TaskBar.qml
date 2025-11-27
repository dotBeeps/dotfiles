pragma ComponentBehavior: Bound
import qs.config
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import Quickshell.Widgets

WrapperRectangle {
    id: taskbar

    property var trayItems: SystemTray.items
    required property var barWindow

    color: "transparent"
    radius: Config.style.bar.radius
    implicitHeight: parent.height

    RowLayout {
        id: buttonRow
        implicitHeight: parent.height

        Repeater {
            model: taskbar.trayItems
            
            TaskBarButton {
                id: trayButton
                Layout.fillHeight: true
                required property SystemTrayItem modelData
                
                source: modelData.icon
                onPressed: () => {
                    console.log(modelData.id)
                    var pos = taskbar.barWindow.mapFromItem(trayButton, implicitWidth / 2, implicitHeight);
                    modelData.display(taskbar.barWindow, pos.x, pos.y);
                }
            }
        }
    }
}
