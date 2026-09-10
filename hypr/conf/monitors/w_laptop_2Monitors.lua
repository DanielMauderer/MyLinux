-- -----------------------------------------------------
-- Monitor Setup
-- name: "Work Laptop - 2 Monitors"
-- -----------------------------------------------------

-- Disable internal display (eDP-1)
hl.monitor({ output = "eDP-1", disabled = true })

-- External monitors with preferred resolution and auto positioning
hl.monitor({ output = "DP-5", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "DP-6", mode = "preferred", position = "auto", scale = 1 })
