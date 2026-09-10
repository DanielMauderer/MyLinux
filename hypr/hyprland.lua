--  _   _                  _                 _
-- | | | |_   _ _ __  _ __| | __ _ _ __   __| |
-- | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
-- |  _  | |_| | |_) | |  | | (_| | | | | (_| |
-- |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--        |___/|_|
--
-- -----------------------------------------------------
-- Hyprland 0.56+ Lua configuration (hyprlang was removed upstream).
-- Modules are plain Lua files loaded with require(); the search path is
-- rooted at this directory, so "conf.monitor" is conf/monitor.lua.
-- -----------------------------------------------------

-- Monitors
require("conf.monitor")

-- Cursor
require("conf.cursor")

-- Keyboard / input
require("conf.keyboard")

-- ML4W window rules and environment
require("conf.ml4w")

-- Look and feel
require("conf.layout")
require("conf.decoration")
require("conf.animation")

-- Workspaces, misc, binds and rules
require("conf.workspace")
require("conf.misc")
require("conf.keybinding")
require("conf.windowrule")
require("conf.focus-mode-rules")

-- Personal additions
require("conf.custom")

-- -----------------------------------------------------
-- Autostart
-- -----------------------------------------------------
hl.on("hyprland.start", function()
    -- Environment for xdg-desktop-portal-hyprland
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    hl.exec_cmd("waybar")

    -- Wallpaper
    hl.exec_cmd("swaybg -i ~/.config/hypr/cache/current_wallpaper.png -m fill")

    -- Material You theming from the current wallpaper
    hl.exec_cmd("fish -c ~/.config/hypr/scripts/apply_matugen.sh")

    -- Screen lock / DPMS
    hl.exec_cmd("swayidle timeout 300 'swaylock' timeout 600 'systemctl suspend'")
end)
