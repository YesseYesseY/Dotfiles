import Quickshell.Services.UPower

BarButton {
    visible: UPower.displayDevice.ready && UPower.displayDevice.isLaptopBattery
    text: {
        let percentage = UPower.displayDevice.percentage * 100
        if (hovered)
            return percentage.toFixed()

        if (!UPower.onBattery) return "\udb80\udc84"

        if (percentage > 90) return "\udb80\udc79" 
        else if (percentage > 80) return "\udb80\udc82" 
        else if (percentage > 70) return "\udb80\udc81" 
        else if (percentage > 60) return "\udb80\udc80" 
        else if (percentage > 50) return "\udb80\udc7f" 
        else if (percentage > 40) return "\udb80\udc7d" 
        else if (percentage > 30) return "\udb80\udc7d" 
        else if (percentage > 20) return "\udb80\udc7c" 
        else if (percentage > 10) return "\udb80\udc7b" 
        else return "\udb80\udc7a"
    }
    textSize: {
        hovered ? 20 : 25
    }
}
