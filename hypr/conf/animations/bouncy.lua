-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                     Hyprland Bouncy Animations                            ║
-- ║                  Fun, playful animations with bounce                      ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

hl.config({ animations = { enabled = true } })

local function bezier(name, x1, y1, x2, y2)
    hl.curve(name, { type = "bezier", points = { { x1, y1 }, { x2, y2 } } })
end

-- Bouncy bezier curves
bezier("bounce", 0.68, -0.55, 0.265, 1.55)
bezier("elastic", 0.28, 0.84, 0.42, 1.15)
bezier("overshot", 0.05, 0.9, 0.1, 1.2)
bezier("wobbly", 0.4, 0, 0.2, 1.2)
bezier("spring", 0.22, 1, 0.36, 1)
bezier("linear", 0, 0, 1, 1)

-- Window animations - bouncy entrance
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 5, bezier = "bounce",   style = "popin 50%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 4, bezier = "elastic",  style = "popin 50%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "overshot", style = "slide" })

-- Fade animations
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 4, bezier = "spring" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 3, bezier = "elastic" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 4, bezier = "spring" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 4, bezier = "spring" })
hl.animation({ leaf = "fadeDim",    enabled = true, speed = 5, bezier = "spring" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 4, bezier = "spring" })

-- Border animations
hl.animation({ leaf = "border",      enabled = true, speed = 12, bezier = "bounce" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 80, bezier = "linear", style = "loop" })

-- Workspace animations - bouncy slide
hl.animation({ leaf = "workspaces",       enabled = true, speed = 6, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "bounce",   style = "slidefadevert -30%" })

-- Layers
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "bounce", style = "popin 70%" })
