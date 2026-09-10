-- -----------------------------------------------------
-- Key bindings
-- name: "Default"
--
-- Every bind carries a description; `hypr/scripts/keybindings.sh`
-- renders them from `hyprctl binds -j`.
-- -----------------------------------------------------

local mainMod = "SUPER"

local HOME        = os.getenv("HOME")
local HYPRSCRIPTS = HOME .. "/.config/hypr/scripts"

-- Convenience wrappers ------------------------------------------------------
local function bind(keys, dispatcher, desc, opts)
    opts = opts or {}
    opts.description = desc
    return hl.bind(keys, dispatcher, opts)
end

local function exec(keys, cmd, desc, opts)
    return bind(keys, hl.dsp.exec_cmd(cmd), desc, opts)
end

-- Applications --------------------------------------------------------------
exec(mainMod .. " + RETURN", "kitty", "Open the terminal")
exec(mainMod .. " + B", "flatpak run app.zen_browser.zen", "Open the browser")
exec(mainMod .. " + E", "Thunar", "Open the file manager")

-- Windows -------------------------------------------------------------------
bind(mainMod .. " + Q", hl.dsp.window.close(), "Kill active window")
exec(mainMod .. " + SHIFT + Q",
    "hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill",
    "Quit active window and all open instances")
bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), "Set active window to fullscreen")
bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }), "Maximize window")
bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }), "Toggle active window into floating mode")

-- Toggle every window on the active workspace between floating and tiled
-- (replaces the old `workspaceopt, allfloat` dispatcher, which no longer exists)
bind(mainMod .. " + SHIFT + T", function()
    local ws = hl.get_active_workspace()
    if not ws then return end

    local windows = ws:get_windows()
    local any_tiled = false
    for _, w in ipairs(windows) do
        if not w.floating then
            any_tiled = true
            break
        end
    end

    local action = any_tiled and "on" or "off"
    for _, w in ipairs(windows) do
        hl.dispatch(hl.dsp.window.float({ action = action, window = "address:" .. w.address }))
    end
end, "Toggle all windows into floating mode")

bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), "Toggle split")
bind(mainMod .. " + K", hl.dsp.layout("swapsplit"), "Swap split")
bind(mainMod .. " + G", hl.dsp.group.toggle(), "Toggle window group")

-- Move focus
bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }),  "Move focus left")
bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), "Move focus right")
bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }),    "Move focus up")
bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }),  "Move focus down")

-- Move / resize with the mouse
bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   "Move window with the mouse",   { mouse = true })
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), "Resize window with the mouse", { mouse = true })

-- Resize with the keyboard
bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x =  100, y =    0 }), "Increase window width")
bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -100, y =    0 }), "Reduce window width")
bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x =    0, y =  100 }), "Increase window height")
bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x =    0, y = -100 }), "Reduce window height")

-- Swap tiled windows
bind(mainMod .. " + ALT + left",  hl.dsp.window.swap({ direction = "left" }),  "Swap tiled window left")
bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }), "Swap tiled window right")
bind(mainMod .. " + ALT + up",    hl.dsp.window.swap({ direction = "up" }),    "Swap tiled window up")
bind(mainMod .. " + ALT + down",  hl.dsp.window.swap({ direction = "down" }),  "Swap tiled window down")

-- Cycle between windows and raise the new one
bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end, "Cycle between windows", { repeating = true })

-- Actions -------------------------------------------------------------------
exec(mainMod .. " + CTRL + R", "hyprctl reload", "Reload Hyprland configuration")
exec(mainMod .. " + SPACE", "pkill rofi || rofi -show drun -replace -i", "Open application launcher")
exec(mainMod .. " + L", "swaylock", "Lock the screen")
exec(mainMod .. " + S", "hyprshot -m region --clipboard-only --freeze", "Screenshot a region to the clipboard")
exec(mainMod .. " + SHIFT + S", "hyprshot -m window --clipboard-only", "Screenshot a window to the clipboard")

-- Workspaces ----------------------------------------------------------------
for i = 1, 10 do
    local key = i % 10 -- workspace 10 lives on key 0
    bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), "Open workspace " .. i)
    bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }),
        "Move active window to workspace " .. i)
    exec(mainMod .. " + CTRL + " .. key, HYPRSCRIPTS .. "/moveTo.sh " .. i,
        "Move all windows to workspace " .. i)
end

bind(mainMod .. " + Tab",         hl.dsp.focus({ workspace = "m+1" }), "Open next workspace")
bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }), "Open previous workspace")

bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), "Open next workspace")
bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), "Open previous workspace")
bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" }), "Open the next empty workspace")

-- Fn keys -------------------------------------------------------------------
exec("XF86MonBrightnessUp",   "brightnessctl -q s +5%", "Increase brightness by 5%")
exec("XF86MonBrightnessDown", "brightnessctl -q s 5%-", "Reduce brightness by 5%")
exec("XF86AudioRaiseVolume",
    "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +5%",
    "Increase volume by 5%")
exec("XF86AudioLowerVolume",
    "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -5%",
    "Reduce volume by 5%")
exec("XF86AudioMute",    "pactl set-sink-mute @DEFAULT_SINK@ toggle", "Toggle mute")
exec("XF86AudioPlay",    "playerctl play-pause", "Audio play/pause")
exec("XF86AudioPause",   "playerctl pause", "Audio pause")
exec("XF86AudioNext",    "playerctl next", "Audio next")
exec("XF86AudioPrev",    "playerctl previous", "Audio previous")
exec("XF86AudioMicMute", "pactl set-source-mute @DEFAULT_SOURCE@ toggle", "Toggle microphone")

-- "XF86Lock" is not a real xkb keysym (Hyprland rejects it); the lock key
-- reports as XF86ScreenSaver.
exec("XF86ScreenSaver", "hyprlock", "Open screenlock")

-- Keyboard backlight
exec("code:238", "brightnessctl -d smc::kbd_backlight s +10", "Increase keyboard backlight")
exec("code:237", "brightnessctl -d smc::kbd_backlight s 10-", "Reduce keyboard backlight")

-- Monitor toggle ------------------------------------------------------------
exec(mainMod .. " + SHIFT + equal", HYPRSCRIPTS .. "/monitor-hotplug.sh", "Toggle monitor setup")

-- Focus mode (zen mode) -----------------------------------------------------
exec(mainMod .. " + Z", HYPRSCRIPTS .. "/focus-mode.sh", "Toggle focus mode for active workspace")
