import QtQuick.Layouts
import qs.modules.common

RowLayout {
    id: root

    property alias iconButton: sliderIconButton
    property alias slider: slider

    spacing: -2

    TextButton {
        id: sliderIconButton

        Layout.fillHeight: true
    }

    StyledSlider {
        id: slider

        snapPoints: [1]
        Layout.fillWidth: true
        from: 0
        to: 1.5
    }

}
