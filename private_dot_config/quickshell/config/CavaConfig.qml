import Quickshell.Io

JsonObject {
    property GeneralSettings general
    property OutputSettings output
    property SmoothingSettings smoothing

    output: OutputSettings {
    }

    smoothing: SmoothingSettings {
    }

    general: GeneralSettings {
    }

    component GeneralSettings: JsonObject {
        property int bars: 22
        property int framerate: 60
        property int autosens: 1
        property int sensitivity: 100
        property int lower_cutoff_freq: 50
        property int higher_cutoff_freq: 12000
    }

    component OutputSettings: JsonObject {
        property string method: "raw"
        property string data_format: "ascii"
        property int ascii_max_range: 100
        property string bit_format: "8bit"
        property string channels: "mono"
        property string mono_option: "average"
    }

    component SmoothingSettings: JsonObject {
        property int monstercat: 0
        property int noise_reduction: 40
    }

}
