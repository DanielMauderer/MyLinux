--    __  _____  _____      __  _____          ___
--   /  |/  / / / / / | /| / / / ___/__  ___  / _/
--  / /|_/ / /_/_  _/ |/ |/ / / /__/ _ \/ _ \/ _/
-- /_/  /_/____//_/ |__/|__/  \___/\___/_//_/_/

-- Pavucontrol floating
hl.window_rule({
    name  = "ml4w-pavucontrol",
    match = { class = ".*org.pulseaudio.pavucontrol.*" },
    float = true, size = "700 600", center = true, pin = true,
})

-- SwayNC
hl.layer_rule({
    name  = "ml4w-swaync-cc-blur",
    match = { namespace = "swaync-control-center" },
    blur = true, ignore_alpha = 0.5,
})
hl.layer_rule({
    name  = "ml4w-swaync-notif-blur",
    match = { namespace = "swaync-notification-window" },
    blur = true, ignore_alpha = 0.5,
})

-- Blueman Manager
hl.window_rule({
    name  = "ml4w-blueman",
    match = { class = "blueman-manager" },
    float = true, size = "800 600", center = true,
})

-- nwg-look
hl.window_rule({
    name  = "ml4w-nwg-look",
    match = { class = "nwg-look" },
    float = true, size = "700 600", move = "10% 20%", pin = true,
})

-- nwg-displays
hl.window_rule({
    name  = "ml4w-nwg-displays",
    match = { class = "nwg-displays" },
    float = true, size = "900 600", move = "10% 20%", pin = true,
})

-- System Mission Center
hl.window_rule({
    name  = "ml4w-missioncenter",
    match = { class = "io.missioncenter.MissionCenter" },
    float = true, pin = true, center = true, size = "900 600",
})

-- System Mission Center preference window
hl.window_rule({
    name  = "ml4w-missioncenter-prefs",
    match = { class = "missioncenter", title = "^(Preferences)$" },
    float = true, pin = true, center = true,
})

-- Gnome Calculator
hl.window_rule({
    name  = "ml4w-calculator",
    match = { class = "org.gnome.Calculator" },
    float = true, size = "700 600", center = true,
})

-- Emoji picker (Smile)
hl.window_rule({
    name  = "ml4w-smile",
    match = { class = "it.mijorus.smile" },
    float = true, pin = true, move = "monitor_w-window_w-40 90",
})

-- Hyprland share picker
hl.window_rule({
    name  = "ml4w-share-picker",
    match = { class = "hyprland-share-picker" },
    float = true, pin = true, center = true, size = "600 400",
})

-- General floating
hl.window_rule({
    name  = "ml4w-dotfiles-floating",
    match = { class = "dotfiles-floating" },
    float = true, size = "1000 700", center = true,
})

-- Floating for Ghostty
hl.window_rule({
    name  = "ml4w-ghostty-floating",
    match = { class = "ml4w.dotfiles.floating" },
    float = true, size = "1000 700", center = true, pin = true,
})

-- ─────────────────────────────────────────────────────────────────────────────
-- Environment variables
-- ─────────────────────────────────────────────────────────────────────────────

-- XDG desktop portal
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE",    "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- QT
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct") -- last one wins, as in the old config
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- GDK
hl.env("GDK_SCALE", "1")

-- Toolkit backend
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")

-- Cursor size for xcursor
hl.env("XCURSOR_SIZE", "24")

-- Ozone
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
