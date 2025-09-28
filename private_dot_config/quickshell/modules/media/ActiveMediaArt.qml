import QtQuick
import qs.config
import qs.modules.common
import qs.services

ClippingImage {
    radius: Config.style.rounding.large
    visible: Players.activePlayer && Players.activePlayer !== null
    source: Players.activePlayer ? Players.activePlayer.trackArtUrl : ''
    image.fillMode: Image.PreserveAspectFit
}
