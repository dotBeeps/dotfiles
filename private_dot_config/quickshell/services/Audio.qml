import Quickshell
import Quickshell.Services.Pipewire
pragma Singleton

Singleton {
    id: root

    readonly property var nodes: Pipewire.nodes.values.reduce((acc, node) => {
        if (!node.isStream) {
            if (node.isSink)
                acc.sinks.push(node);
            else if (node.audio)
                acc.sources.push(node);
        }
        return acc;
    }, {
        "sources": [],
        "sinks": []
    })

    readonly property list<PwNode> sinks: nodes.sinks
    readonly property list<PwNode> sources: nodes.sources

    readonly property PwNode defaultSink: Pipewire.defaultAudioSink
    readonly property PwNode defaultSource: Pipewire.defaultAudioSource

    readonly property bool muted: !!defaultSink?.audio?.muted
    readonly property real volume: defaultSink?.audio?.volume ?? 0
    readonly property bool sourceMuted: !!defaultSource?.audio?.muted
    readonly property real sourceVolume: defaultSource?.audio?.volume ?? 0

    function setVolume(newVol: real): void {
        if (defaultSink?.ready && defaultSink?.audio) {
            defaultSink.audio.muted = false;
            defaultSink.audio.volume = Math.max(0, Math.min(1.5,newVol))
        }
    }
    function setSourceVolume(newVol: real): void {
        if (defaultSource?.ready && defaultSource?.audio) {
            defaultSource.audio.muted = false;
            defaultSource.audio.volume = Math.max(0, Math.min(1.5,newVol))
        }
    }

    function setDefaultSink(newSink: PwNode): void {
        Pipewire.preferredDefaultAudioSink = newSink;
    }

    function setDefaultSource(newSource: PwNode): void {
        Pipewire.preferredDefaultAudioSource = newSource;
    }

    PwObjectTracker {
        objects: [...root.sinks, ...root.sources]
    }
}
