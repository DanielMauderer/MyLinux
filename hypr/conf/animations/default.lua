-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                      Hyprland Animations Config                           ║
-- ║              Smooth, premium animations for your desktop                  ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

hl.config({ animations = { enabled = true } })

-- ─────────────────────────────────────────────────────────────────────────────
-- Bezier curves - the magic behind smooth animations
-- ─────────────────────────────────────────────────────────────────────────────
local function bezier(name, x1, y1, x2, y2)
    hl.curve(name, { type = "bezier", points = { { x1, y1 }, { x2, y2 } } })
end

-- Standard Material Design curves
bezier("md3_standard", 0.2, 0, 0, 1)
bezier("md3_decel", 0.05, 0.7, 0.1, 1)
bezier("md3_accel", 0.3, 0, 0.8, 0.15)

-- Emphasized curves for dramatic effect
bezier("emphasized", 0.2, 0, 0, 1)
bezier("emphasized_decel", 0.05, 0.9, 0.1, 1)
bezier("emphasized_accel", 0.3, 0, 0.8, 0.15)

-- Bouncy / elastic curves
bezier("overshot", 0.05, 0.9, 0.1, 1.1)
bezier("bounce", 0.68, -0.55, 0.265, 1.55)
bezier("elastic", 0.28, 0.84, 0.42, 1)

-- Smooth / soft curves
bezier("smooth", 0.25, 0.1, 0.25, 1)
bezier("smoothOut", 0.36, 0, 0.66, -0.56)
bezier("smoothIn", 0.25, 1, 0.5, 1)

-- Apple-style curves
bezier("apple", 0.25, 0.1, 0, 1)
bezier("appleSwift", 0.55, 0.055, 0.675, 0.19)

-- Custom fluid curves
bezier("fluid", 0.05, 0.85, 0, 1)
bezier("snappy", 0.4, 0, 0.2, 1)
bezier("expo", 0.87, 0, 0.13, 1)
bezier("linear", 0, 0, 1, 1)

-- ─────────────────────────────────────────────────────────────────────────────
-- Window animations
-- ─────────────────────────────────────────────────────────────────────────────
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 4, bezier = "md3_decel",    style = "popin 60%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3, bezier = "md3_accel",    style = "popin 60%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "md3_standard", style = "slide" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Fade animations
-- ─────────────────────────────────────────────────────────────────────────────
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 2, bezier = "md3_accel" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 3, bezier = "md3_standard" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 3, bezier = "md3_standard" })
hl.animation({ leaf = "fadeDim",    enabled = true, speed = 4, bezier = "md3_standard" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 3, bezier = "md3_decel" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Border animations (for the gradient borders)
-- ─────────────────────────────────────────────────────────────────────────────
hl.animation({ leaf = "border",      enabled = true, speed = 10,  bezier = "md3_standard" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "linear", style = "loop" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Workspace animations
-- ─────────────────────────────────────────────────────────────────────────────
hl.animation({ leaf = "workspaces",       enabled = true, speed = 5, bezier = "md3_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "md3_decel", style = "slidefadevert -50%" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Layers (rofi, waybar popups, etc.)
-- ─────────────────────────────────────────────────────────────────────────────
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 80%" })
