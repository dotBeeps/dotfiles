import Quickshell
pragma Singleton

Singleton {
    id: root

    readonly property string date: {
        Qt.formatDateTime(clock.date, "ddd MM/dd/yy");
    }
    readonly property string shortDate: {
        Qt.formatDateTime(clock.date, "ddd MM/dd");
    }
    readonly property string time: {
        Qt.formatDateTime(clock.date, "h:mm ap");
    }
    readonly property string clockTime: {
        clock.date.getTime();
    }

    SystemClock {
        id: clock

        precision: SystemClock.Seconds
    }

}
