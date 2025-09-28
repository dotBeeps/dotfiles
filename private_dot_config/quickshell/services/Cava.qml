import Quickshell
import Quickshell.Io
import qs.config
pragma Singleton

Singleton {
    id: root

    property alias running: cava.running
    property var values: Array(Config.cava.general.bars).fill(0)

    Process {
        id: cava

        command: ["cava", "-p", "/dev/stdin"]
        running: true
        stdinEnabled: true
        onExited: {
            stdinEnabled = true;
            root.values = Array(Config.cava.general.bars).fill(0);
        }
        onStarted: {
            for (const k in Config.cava) {
                if (typeof Config.cava[k] !== "object") {
                    write(`${k}=${Config.cava[k]}\n`);
                    continue;
                }
                write(`[${k}]\n`);
                const obj = Config.cava[k];
                for (const k2 in obj) {
                    write(`${k2}=${Config.cava[k][k2]}\n`);
                }
            }
            stdinEnabled = false;
            root.values = Array(Config.cava.general.bars).fill(0);
        }

        stdout: SplitParser {
            id: out

            onRead: (data) => {
                root.values = data.slice(0, -1).split(';').map((v) => {
                    return parseInt(v, 10) / 100;
                });
            }
        }

    }

}
