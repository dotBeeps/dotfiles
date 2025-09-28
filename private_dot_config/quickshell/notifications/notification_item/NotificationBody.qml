import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import Quickshell.Widgets
import qs.config

RowLayout {
    id: root

    required property Notification notification
    required property string mainImage
    property bool hovered: false

    spacing: Config.style.spacing.sm
    Layout.fillWidth: true
    Layout.fillHeight: true

    IconImage {
        implicitSize: 42
        source: root.mainImage
        Layout.alignment: Qt.AlignTop
    }

    ColumnLayout {
        Layout.fillHeight: true
        Layout.fillWidth: true

        Text {
            text: root.notification.summary
            color: Config.activeColors.inactive
            verticalAlignment: Text.AlignTop
            Layout.fillHeight: false
            Layout.fillWidth: true

            font {
                family: Config.style.fonts.mono
                pointSize: 12
                weight: 100
            }

        }

        Text {
            text: root.notification.body
            elide: Text.ElideRight
            color: Config.activeColors.text
            Layout.fillHeight: true
            Layout.fillWidth: true
            maximumLineCount: 6
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop

            font {
                family: Config.style.fonts.mono
                pointSize: 14
                weight: 100
            }

        }

    }

}
