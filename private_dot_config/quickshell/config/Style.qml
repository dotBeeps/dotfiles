import Quickshell.Io

JsonObject {
    property Fonts fonts
    property Rounding rounding
    property Spacing spacing
    property Bar bar

    fonts: Fonts {
    }

    rounding: Rounding {
    }

    spacing: Spacing {
    }

    bar: Bar {
    }

    component Fonts: JsonObject {
        property string mono: "Monofur Nerd Font Mono"
        property string propo: "Monofur Nerd Font Propo"
        property string symbolsMono: "Symbols Nerd Font Mono"
        property string symbols: "Symbols Nerd Font"
        property int pointSizeBase: 14
        property int ptSm: pointSizeBase - 2
        property int ptXs: ptSm - 2
        property int ptMd: pointSizeBase
        property int ptLg: ptMd + 2
        property int ptXl: ptLg + 4
        property int ptXxl: ptXl + 4
        property int ptXxxl: ptXxl + 4
    }

    component Rounding: JsonObject {
        property real scale: 1
        property int xs: 8 * scale
        property int small: 12 * scale
        property int medium: 16 * scale
        property int large: 24 * scale
        property int xl: 32 * scale
        property int full: 1000
    }

    component Spacing: JsonObject {
        property real scale: 1
        property int xxs: 4 * scale
        property int xs: 8 * scale
        property int sm: 14 * scale
        property int md: 20 * scale
        property int lg: 32 * scale
        property int xl: 46 * scale
        property int xxl: 52 * scale
    }

    component Bar: JsonObject {
        property int height: 50
        property int fontSize: 16
        property real opacity: 0.9
        property int radius: 20
    }

}
