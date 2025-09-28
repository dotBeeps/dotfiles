import QtQuick
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell.Services.Mpris
import qs.config
import qs.services
import qs.modules.media


ClippingWrapperRectangle {
    id: root
    radius: Config.style.rounding.small
    color: Config.activeColors.base.darker(1.5).alpha(.9)
    margin: Config.style.spacing.sm
    leftMargin: Config.style.spacing.md
    rightMargin: Config.style.spacing.md


    RowLayout {
        id: mediaTime
        property var currentTime: Players.activePlayer?.position??0
        property var endTime: Players.activePlayer?.length??0
        property var startTime: 0
        function formatSecMinSec(t) { return `${Math.floor(t / 60)}:${(t % 60).toFixed(0).toString().padStart(2,"0")}` }
        property string timeStr: formatSecMinSec(currentTime > endTime ? currentTime - endTime : currentTime)
        property string durationStr: formatSecMinSec(Players.activePlayer?.length??0)
        implicitHeight: mediaSlider.implicitHeight + 41
        spacing: Config.style.spacing.sm
        Text {
            visible: mediaTime.endTime !== 0 || mediaTime.startTime !== 0
            text: mediaTime.timeStr
            verticalAlignment: Text.AlignVCenter
            font.family: Config.style.fonts.mono
            color: Config.activeColors.text
        }
        MediaSlider {
            id: mediaSlider
            from: mediaTime.startTime
            to: mediaTime.endTime
            value: mediaTime.currentTime
            Layout.fillWidth: true
            onMoved: {
                if (Players.activePlayer?.canSeek) {
                    Players.activePlayer.position = value
                }
            }
        }
        Text {
            visible: (mediaTime.endTime !== 0 || mediaTime.startTime !== 0) && (mediaTime.currentTime <= mediaTime.endTime)
            text: mediaTime.durationStr
            verticalAlignment: Text.AlignVCenter
            font.family: Config.style.fonts.mono
            color: Config.activeColors.text
        }
        FrameAnimation {
                running: Players.activePlayer?.playbackState == MprisPlaybackState.Playing
                onTriggered: Players.activePlayer?.positionChanged()
    }
    }
}

