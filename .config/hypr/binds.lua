local main_mod = "SUPER"

local terminal = "alacritty"
local menu = "hyprlauncher" -- "wofi -i --show drun"

hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + DELETE", hl.dsp.window.close())
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd("dolphin"))
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(main_mod .. " + SHIFT + J", hl.dsp.layout("swapsplit"))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind(main_mod .. " + SHIFT + F", hl.dsp.window.fullscreen())

for i, dir in pairs({ "up", "right", "down", "left" }) do
    hl.bind(main_mod .. " + " .. dir, hl.dsp.focus({ direction = dir }))
    hl.bind(main_mod .. " + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }))
end

for i = 1, 10 do
    local key = i % 10
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i}))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i}))
end

-- Fermium
local function launch_fermium_client()
    hl.dispatch(hl.dsp.exec_cmd(
        "wine /home/yes/Apps/FNL " ..
        "\"Z:/home/yes/WinApps/$(hyprlauncher -o $(ls ~/WinApps/ | grep \"[0-9]*\\.[0-9]*\" | tr \"\n\" \",\"))\" " ..
        "\"-iZ:/home/yes/Apps/redirect.dll\" " ..
        "\"-w30000\" \"-iZ:/home/yes/Programming/Fermium/bin/FermiumClient.dll\" "))
end

local function launch_fermium_server()
    hl.dispatch(hl.dsp.exec_cmd(
        "wine /home/yes/Apps/FNL " ..
        "\"Z:/home/yes/WinApps/$(hyprlauncher -o $(ls ~/WinApps/ | grep \"[0-9]*\\.[0-9]*\" | tr \"\n\" \",\"))\" " ..
        "-h " ..
        "\"-iZ:/home/yes/Apps/redirect.dll\" " ..
        "\"-w20000\" \"-iZ:/home/yes/Programming/Fermium/bin/FermiumServer.dll\" "))
end

hl.bind(main_mod .. " + F11", launch_fermium_client)
hl.bind(main_mod .. " + F12", launch_fermium_server)

-- Mouse
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
