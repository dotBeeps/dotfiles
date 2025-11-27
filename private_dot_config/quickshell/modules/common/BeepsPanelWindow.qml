import Quickshell
import Quickshell.Wayland
import qs.config

PanelWindow {
    property bool blur: true
    WlrLayershell.namespace: blur ? Config.layerNamespace : Config.layerNamespaceNoBlur
}
