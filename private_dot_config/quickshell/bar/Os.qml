import QtQuick
import qs.config

Text {
    id: system

    text: "󰩃"
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    color: Config.activeColors.text
    font.family: Config.style.fonts.symbols
    font.pointSize: 18
}
