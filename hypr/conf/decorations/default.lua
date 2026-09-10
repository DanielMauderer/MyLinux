-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                     Hyprland Decorations Config                           ║
-- ║              Window styling with animated gradient borders                ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

local c = require("colors")

hl.config({
    decoration = {
        rounding = 12,

        -- Opacity
        active_opacity     = 1.0,
        inactive_opacity   = 0.92,
        fullscreen_opacity = 1.0,

        blur = {
            enabled            = true,
            size               = 8,
            passes             = 3,
            new_optimizations  = true,
            ignore_opacity     = true,
            xray               = false,
            noise              = 0.02,
            contrast           = 1.0,
            brightness         = 1.0,
            vibrancy           = 0.2,
            vibrancy_darkness  = 0.2,
            special            = true,
            popups             = true,
            popups_ignorealpha = 0.2,
        },

        shadow = {
            enabled        = true,
            range          = 25,
            render_power   = 3,
            color          = "rgba(00000055)",
            color_inactive = "rgba(00000033)",
            offset         = { 0, 4 },
            scale          = 1.0,
        },

        -- Dim inactive windows
        dim_inactive = true,
        dim_strength = 0.1,
        dim_special  = 0.3,
        dim_around   = 0.4,
    },

    general = {
        border_size = 3,

        col = {
            -- Animated gradient using the matugen palette; the 45deg angle is
            -- rotated by the borderangle animation for the rainbow effect.
            active_border = {
                colors = { c.primary, c.tertiary, c.secondary, c.primary },
                angle  = 45,
            },
            inactive_border = {
                colors = { c.surface_variant, c.outline_variant },
                angle  = 45,
            },
        },

        -- Resize border (when resizing)
        resize_on_border        = true,
        extend_border_grab_area = 15,
        hover_icon_on_border    = true,

        -- Gaps
        gaps_in         = 4,
        gaps_out        = 8,
        gaps_workspaces = 0,

        layout = "dwindle",

        -- Allow tearing (for games)
        allow_tearing = false,
    },
})

-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                       Alternative Border Styles                           ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝
-- Rainbow:   { colors = { "rgb(ff6b6b)", "rgb(feca57)", "rgb(48dbfb)", "rgb(ff9ff3)", "rgb(54a0ff)" }, angle = 45 }
-- Catppuccin:{ colors = { "rgb(cba6f7)", "rgb(89b4fa)", "rgb(94e2d5)", "rgb(f5c2e7)" }, angle = 45 }
-- Neon glow: { colors = { "rgb(00ff88)", "rgb(00aaff)", "rgb(aa00ff)", "rgb(ff0088)" }, angle = 45 }
-- Sunset:    { colors = { "rgb(ff6b35)", "rgb(f7931e)", "rgb(fbb034)", "rgb(ffdd00)" }, angle = 45 }
-- Ocean:     { colors = { "rgb(0077b6)", "rgb(00b4d8)", "rgb(90e0ef)", "rgb(caf0f8)" }, angle = 45 }
-- Aurora:    { colors = { "rgb(00ff87)", "rgb(60efff)", "rgb(00b4db)", "rgb(b721ff)" }, angle = 45 }
