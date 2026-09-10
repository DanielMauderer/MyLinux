-- -----------------------------------------------------
-- Keyboard / input
-- https://wiki.hypr.land/Configuring/Variables/#input
-- -----------------------------------------------------

hl.config({
    input = {
        kb_layout  = "eu",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",

        numlock_by_default = true,
        mouse_refocus      = false,

        -- For United States:
        -- kb_layout = "us", kb_variant = "intl", kb_model = "pc105",

        follow_mouse = 1,

        -- Pointer speed: -1.0 - 1.0, 0 means no modification.
        sensitivity = 0,

        touchpad = {
            -- for desktop
            natural_scroll = false,

            -- for laptop
            -- natural_scroll = true,
            -- middle_button_emulation = true,
            -- clickfinger_behavior = false,
            scroll_factor = 1.0,
        },
    },
})
