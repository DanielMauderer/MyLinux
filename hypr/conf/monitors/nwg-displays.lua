-- -----------------------------------------------------
-- Monitor Setup
-- name: "nwg-displays"
-- -----------------------------------------------------
--
-- nwg-displays still writes hyprlang (`~/.config/hypr/monitors.conf` and
-- `workspaces.conf`), which Hyprland 0.56 can no longer read. Until it grows
-- Lua output, translate its files by hand into conf/monitors/<profile>.lua.

error("conf/monitors/nwg-displays.lua: nwg-displays writes hyprlang, which Hyprland no longer supports")
