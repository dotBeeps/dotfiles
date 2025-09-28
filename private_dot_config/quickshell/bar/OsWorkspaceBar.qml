import QtQuick.Layouts
import Quickshell.Widgets
import qs.config
import "workspaces"

WrapperItem {
    implicitHeight: parent.height

    RowLayout {
        spacing: Config.style.spacing.sm

        Os {
        }

        Workspaces {
        }

    }

}
