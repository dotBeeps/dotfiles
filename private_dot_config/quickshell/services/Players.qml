import Quickshell
import Quickshell.Services.Mpris
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
}
