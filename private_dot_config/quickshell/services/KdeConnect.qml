import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    readonly property alias isCharging: phoneChargingProc.isCharging
    readonly property alias chargeLevel: phoneBatProc.chargeLevel

    Process {
        id: phoneChargingProc

        property bool isCharging: false

        command: ["qdbus", "org.kde.kdeconnect", "/modules/kdeconnect/devices/a5af9cf6bba7472da0966ccd0e21fb6b/battery", "org.kde.kdeconnect.device.battery.isCharging"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: phoneChargingProc.isCharging = this.text.startsWith("true")
        }

    }

    Process {
        id: phoneBatProc

        property real chargeLevel: 0

        command: ["qdbus", "org.kde.kdeconnect", "/modules/kdeconnect/devices/a5af9cf6bba7472da0966ccd0e21fb6b/battery", "org.kde.kdeconnect.device.battery.charge"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: phoneBatProc.chargeLevel = Number(this.text.trim()) / 100
        }

    }

    Timer {
        id: phoneBatTimer

        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            phoneBatProc.running = true;
            phoneChargingProc.running = true;
        }
    }

}
