import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import qs.config
import qs.modules.common
import qs.services
pragma Singleton

Singleton {
    id: root

    readonly property list<MprisPlayer> list: Mpris.players.values
    readonly property MprisPlayer activePlayer: list.find((p) => {
        return p.isPlaying;
    }) ?? list.find(p => p.identity === activePlayer?.identity) ?? null

    function play(): void {
        const active = root.activePlayer;
        if (active?.canPlay)
            active.play()
    }

    function pause(): void {
        const active = root.activePlayer;
        if (active?.canPause)
            active.pause()
    }

    function togglePlay(): void {
        const active = root.activePlayer;
        if (active.canTogglePlaying) {
            active.togglePlaying();
        }
    }

    function previous(): void {
        const active = root.activePlayer;
        if (active?.canGoPrevious)
            active.previous()
    }

    function next(): void {
        const active = root.activePlayer;
        if (active?.canGoNext)
            active.next()
    }

    function stop(): void {
        root.activePlayer?.stop();
    }

    component ActiveArt: ClippingImage {
        visible: (Players.activePlayer?.trackArtUrl ?? '') !== '' 
        source: Players.activePlayer.trackArtUrl
        image.fillMode: Image.PreserveAspectFit
    }

    component ActiveIcon: ClippingIconImage {
        implicitSize: 24
        visible: (Players.activePlayer?.desktopEntry ?? '') !== ''
        source: Quickshell.iconPath(Players.activePlayer.desktopEntry)
        radius: Config.style.rounding.full
    }
    component ActiveArtist: Text {
        text: Players.activePlayer?.trackArtist ?? ''
        color: Config.colors.text
        elide: Text.ElideMiddle
        verticalAlignment: Text.Bottom
        visible: text !== ''
        font {
            family: Config.style.fonts.mono
            pointSize: 12
        }
    }
    component ActiveTitle: Text {
        text: Players.activePlayer?.trackTitle ?? ''
        color: Config.colors.text
        elide: Text.ElideMiddle
        verticalAlignment: Text.Top
        font {
            family: Config.style.fonts.mono
            pointSize: 16
            weight: 600
        }
    }
}
