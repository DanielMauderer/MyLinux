-- -----------------------------------------------------
-- Cursor
-- -----------------------------------------------------

local function apply_cursor()
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
end

-- Applied at login and again after every `hyprctl reload` (setcursor is
-- idempotent, and a reload otherwise drops back to the default theme).
hl.on("hyprland.start", apply_cursor)
hl.on("config.reloaded", apply_cursor)
