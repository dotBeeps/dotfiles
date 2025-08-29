import ".."
import QtQuick.Layouts
import Quickshell.Widgets
import "workspaces"

WrapperItem {
    implicitHeight: parent.height

    RowLayout {
        spacing: Config.gapSm

        Os {
        }

        Workspaces {
        }

    }

}
