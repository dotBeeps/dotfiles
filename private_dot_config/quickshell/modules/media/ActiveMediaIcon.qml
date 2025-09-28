import Quickshell
import qs.config
import qs.modules.common
import qs.services

ClippingIconImage {
    id: root

    implicitSize: 24
    source: Quickshell.iconPath(Players.activePlayer.desktopEntry)
    radius: Config.style.rounding.full
}
