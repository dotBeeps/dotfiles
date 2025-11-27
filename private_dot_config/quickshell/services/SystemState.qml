import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    function powerAction(action) {
    switch (action) {
            case 0:
                SystemState.suspend();
                break;
            case 1:
                SystemState.bigPicture();
                break;
            case 2:
                SystemState.suspend();                    
                break;
            case 3:
                SystemState.restart();
                break;
            case 4:
                SystemState.poweroff();
                break;
            default:
                break;
        }
    }

    function poweroff() {
        poweroffProc.running = true;
    }

    function bigPicture() {
        bigPictureProc.running = true;
    }

    function restart() {
        restartProc.running = true;
    }

    function suspend() {
        suspendProc.running = true;
    }
        
    Process {
        id: poweroffProc
        running: false
        command: ["poweroff"]
    }
    
    Process {
        id: bigPictureProc
        running: false
        command: ["scb", "-e", "-f", "--", "steam", "-gamepadui"]
    }

    Process {
        id: restartProc
        running: false
        command: ["reboot"]
    }


    Process {
        id: suspendProc
        running: false
        command: ["systemctl", "suspend"]
    }
}
