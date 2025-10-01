import Quickshell
pragma Singleton

Singleton {
    id: root

    readonly property string home: Quickshell.env("HOME")
    readonly property string config: `${Quickshell.env("XDG_CONFIG_HOME") || `${home}/.config`}/beepshell`
    readonly property string stickers: `${home}/Pictures/stickers`
}
