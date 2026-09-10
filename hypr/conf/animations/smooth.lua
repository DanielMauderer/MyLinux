-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                    Hyprland Smooth Animations                             ║
-- ║              Extra smooth, slower animations for relaxed feel             ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

hl.config({ animations = { enabled = true } })

local function bezier(name, x1, y1, x2, y2)
    hl.curve(name, { type = "bezier", points = { { x1, y1 }, { x2, y2 } } })
end

-- Smooth bezier curves
bezier("smooth", 0.25, 0.1, 0.25, 1)
bezier("smoothOut", 0.36, 0, 0.66, -0.56)
bezier("smoothIn", 0.25, 1, 0.5, 1)
bezier("gentle", 0.4, 0, 0.2, 1)
bezier("softBounce", 0.34, 1.56, 0.64, 1)
bezier("linear", 0, 0, 1, 1)

-- Window animations - extra smooth
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 6, bezier = "softBounce", style = "popin 70%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5, bezier = "smooth",     style = "popin 70%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "gentle",     style = "slide" })

-- Fade animations
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 5, bezier = "smooth" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 4, bezier = "smooth" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 5, bezier = "smooth" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 5, bezier = "smooth" })
hl.animation({ leaf = "fadeDim",    enabled = true, speed = 6, bezier = "smooth" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 5, bezier = "smooth" })

-- Border animations
hl.animation({ leaf = "border",      enabled = true, speed = 15,  bezier = "smooth" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "linear", style = "loop" }) -- was 150; Hyprland caps speed at 100

-- Workspace animations - gentle slide
hl.animation({ leaf = "workspaces",       enabled = true, speed = 7, bezier = "gentle", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 6, bezier = "gentle", style = "slidefadevert -40%" })

-- Layers
hl.animation({ leaf = "layers", enabled = true, speed = 5, bezier = "smooth", style = "popin 85%" })
