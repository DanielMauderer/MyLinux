-- -----------------------------------------------------
-- Monitor Setup
-- name: "Work Laptop - 1 Monitor (Home)"
-- -----------------------------------------------------

-- Enable internal display (eDP-1)
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })

-- External HDMI monitor, preferred resolution, auto positioned
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 1 })
