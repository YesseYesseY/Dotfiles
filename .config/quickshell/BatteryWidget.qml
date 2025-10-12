import Quickshell.Services.UPower

BarButton {
    visible: UPower.displayDevice.ready && UPower.displayDevice.isLaptopBattery
    text: {
        if (hovered)
            return (UPower.displayDevice.percentage * 100).toFixed()

        UPower.onBattery ? "󰁹" : "󰂄"
    }
    textSize: {
        hovered ? 20 : 25
    }
}
