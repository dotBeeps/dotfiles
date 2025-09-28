import Quickshell.Io

JsonObject {
    property NotificationProperties defaults
    property list<var> overrides

    defaults: NotificationProperties {
    }

    component NotificationProperties: JsonObject {
        property int timeout: 5000
        property string app
        property string mainIcon: "app"
        property bool showAppHint: true
    }

}
