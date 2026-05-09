local monitors = hl.get_monitors()
if io.popen("hostnamectl chassis"):read() == "laptop" then
    hl.monitor({
      output = "eDP-1",
      mode = "2560x1600@165",
      position = "0x0",
      scale = 1.6,
    })
else
    hl.monitor({
      output = "HDMI-A-1",
      mode = "1920x1080@60",
      position = "2560x360",
      scale = 1,
    })
    hl.monitor({
      output = "DP-2",
      mode = "2560x1440@240",
      position = "0x0",
      scale = 1,
    })
    hl.monitor({
      output = "HDMI-A-2",
      mode = "1920x1080@60",
      position = "-1920x360",
      scale = 1,
    })
end
