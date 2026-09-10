-- -----------------------------------------------------
-- Window rules
-- -----------------------------------------------------

-- Browsers that should always tile
for name, title in pairs({
    ["wr-tile-edge"]     = "^(Microsoft-edge)$",
    ["wr-tile-brave"]    = "^(Brave-browser)$",
    ["wr-tile-chromium"] = "^(Chromium)$",
}) do
    hl.window_rule({ name = name, match = { title = title }, tile = true })
end

-- Small tools that should always float
for name, title in pairs({
    ["wr-float-pavucontrol"] = "^(pavucontrol)$",
    ["wr-float-blueman"]     = "^(blueman-manager)$",
    ["wr-float-nm-editor"]   = "^(nm-connection-editor)$",
    ["wr-float-qalculate"]   = "^(qalculate-gtk)$",
}) do
    hl.window_rule({ name = name, match = { title = title }, float = true })
end

-- Browser Picture in Picture
hl.window_rule({
    name  = "wr-pip",
    match = { title = "^(Picture-in-Picture)$" },

    float   = true,
    pin     = true,
    move    = "69.5% 4%",
    opacity = "1.0 override",
})

-- idleinhibit - available modes: none, always, focus, fullscreen
hl.window_rule({
    name  = "wr-idleinhibit",
    match = { class = ".*" },

    idle_inhibit = "fullscreen",
})

hl.layer_rule({ name = "lr-noanim-hyprpicker", match = { namespace = "hyprpicker" }, no_anim = true })
hl.layer_rule({ name = "lr-noanim-selection",  match = { namespace = "selection" },  no_anim = true })
