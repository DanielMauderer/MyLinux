-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                     Hyprland Snappy Animations                            ║
-- ║              Fast, responsive animations for productivity                 ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

hl.config({ animations = { enabled = true } })

local function bezier(name, x1, y1, x2, y2)
    hl.curve(name, { type = "bezier", points = { { x1, y1 }, { x2, y2 } } })
end

-- Snappy bezier curves
bezier("snappy", 0.4, 0, 0.2, 1)
bezier("quick", 0.25, 0, 0.5, 1)
bezier("instant", 0.05, 0.7, 0.1, 1)
bezier("sharp", 0.5, 0, 0.1, 1)
bezier("linear", 0, 0, 1, 1)

-- Window animations - quick and responsive
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 2, bezier = "instant", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 2, bezier = "sharp",   style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2, bezier = "snappy",  style = "slide" })

-- Fade animations - very quick
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 2, bezier = "instant" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 1, bezier = "sharp" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 2, bezier = "snappy" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 2, bezier = "snappy" })
hl.animation({ leaf = "fadeDim",    enabled = true, speed = 2, bezier = "snappy" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 2, bezier = "instant" })

-- Border animations
hl.animation({ leaf = "border",      enabled = true, speed = 5,  bezier = "snappy" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 50, bezier = "linear", style = "loop" })

-- Workspace animations - instant feel
hl.animation({ leaf = "workspaces",       enabled = true, speed = 3, bezier = "instant", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "instant", style = "slidefadevert -60%" })

-- Layers
hl.animation({ leaf = "layers", enabled = true, speed = 2, bezier = "instant", style = "popin 90%" })
