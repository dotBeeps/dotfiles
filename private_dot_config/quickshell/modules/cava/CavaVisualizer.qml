pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.services

Item {
    id: root
    RowLayout {
        id: bars

        anchors.fill: parent
        uniformCellSizes: true

        Repeater {
            model: Cava.values

            Rectangle {
                id: bar

                required property var modelData
                implicitHeight: 1 + modelData * bars.height
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

        }

    }

}
