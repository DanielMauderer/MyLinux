#!/bin/bash
#     _    _ _  __ _             _
#    / \  | | |/ _| | ___   __ _| |_
#   / _ \ | | | |_| |/ _ \ / _` | __|
#  / ___ \| | |  _| | (_) | (_| | |_
# /_/   \_\_|_|_| |_|\___|_\__,_|\__|
#
# Hyprland 0.56 removed the `workspaceopt allfloat` dispatcher, so the same
# thing is done from Lua: float every window on the active workspace, or tile
# them all again if none is tiled.

hyprctl eval '
    local ws = hl.get_active_workspace()
    if not ws then return end
    local windows = ws:get_windows()
    local any_tiled = false
    for _, w in ipairs(windows) do
        if not w.floating then any_tiled = true break end
    end
    local action = any_tiled and "on" or "off"
    for _, w in ipairs(windows) do
        hl.dispatch(hl.dsp.window.float({ action = action, window = "address:" .. w.address }))
    end
'
notify-send "Windows on this workspace toggled to floating/tiling"
