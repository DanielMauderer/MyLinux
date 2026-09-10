-- -----------------------------------------------------
-- Layouts (laptop: adds touchpad workspace swipe)
-- -----------------------------------------------------

require("conf.layouts.default")

-- Three-finger horizontal swipe to change workspace
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})
