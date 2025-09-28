import QtQuick
import Quickshell.Io

JsonObject {
    property string currentTheme: "defaultTheme"
    property JsonObject themes

    component Theme: JsonObject {
        property color base: "#FC20272f"
        property color baseSolid: "#20272f"
        property color shadow: "#232230"
        property color highlight: "#2b3b4a"
        property color dark: "#f20c0f12"
        property color urgent: "#e087b4"
        property color accent: "#86cecb"
        property color highlightAccent: "#a1f9f5"
        property color text: "#e7edf2"
        property color highlightOverlay: "#10e7edf2"
        property color outline: "#d9dee2"
        property color inactive: "#a0d9dee2"
    }

    themes: JsonObject {
        property Theme defaultTheme

        defaultTheme: Theme {
        }

    }

}
