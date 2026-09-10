#!/bin/bash
#  _              _     _           _ _
# | | _____ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
# | |/ / _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
# |   <  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
# |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
#           |___/                             |___/
#
# -----------------------------------------------------
# Show the active keybindings in rofi.
#
# Since Hyprland 0.56 the config is Lua, so the binds are read straight from
# the compositor instead of being scraped out of a config file. Every bind in
# conf/keybindings/*.lua carries a `description`.
# -----------------------------------------------------

keybinds=$(hyprctl binds -j | jq -r '
    def mods(m):
        [ if (m / 64) % 2 >= 1 then "SUPER" else empty end,
          if (m / 4)  % 2 >= 1 then "CTRL"  else empty end,
          if (m / 8)  % 2 >= 1 then "ALT"   else empty end,
          if (m / 1)  % 2 >= 1 then "SHIFT" else empty end ]
        | join(" + ");

    .[]
    | select(.description != "")
    | ((mods(.modmask) | if . == "" then "" else . + " + " end)
       + (if .key != "" then .key else "code:" + (.keycode | tostring) end))
      + "\r" + .description
')

sleep 0.2
rofi -dmenu -i -markup -eh 2 -replace -p "Keybinds" -config ~/.config/rofi/config-compact.rasi <<<"$keybinds"
