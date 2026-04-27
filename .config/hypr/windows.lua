hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name = "float-pavu",
    match = {
        class = "org.pulseaudio.pavucontrol",
        title = "Volume Control"
    },

    float = true,
    size = "(monitor_w*0.5) (monitor_h*0.5)"
})

hl.window_rule({
    name = "float-steam-friends",
    match = {
        class = "steam",
        title = "Friends List"
    },

    float = true,
    center = true,
    size = "(monitor_w*0.25) (monitor_h*0.75)"
})
