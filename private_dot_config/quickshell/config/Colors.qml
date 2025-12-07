import QtQuick
import Quickshell.Io

JsonObject {
    property string currentTheme: "dotBeeps"
    property string currentPalette: "dotBeeps"
    property JsonObject themes
    property JsonObject palettes
    
    component Palette: JsonObject {
        property color lavender: "#997DCE"
        property color pink: "#E087B4"
        property color peach: "#F7BF8B"
        property color yellow: "#FFEF96"
        property color green: "#D1EDAD"
        property color skyblue: "#B0E8E5"
        property color blue: "#6295CE"
        property color gray: "#54667B"
        property color base: "#20272F"
        property color mantle: "#161B21"
        property color crust: "#0C0F12"
        property color mid: "#B2BDCA"
        property color light: "#D1D8E0"
        property color lighter: "#DDE2E9"
        property color lightest: "#EDF0F3"
    }

    component Theme: JsonObject {
        property string base: "base"
        property string shadow: "mantle"
        property string dark: "crust"
        property string highlight: "gray"
        property string highlightBright: "mid"
        property string accent: "skyblue"
        property string accentSecondary: "pink"
        property string text: "lightest"
        property string outline: "light"
        property string inactive: "skyblue"
    }

    themes: JsonObject {
        property Theme dotBeeps

        dotBeeps: Theme {
        }

    }

    palettes: JsonObject {
        property Palette dotBeeps

        dotBeeps: Palette {}
    }

}
