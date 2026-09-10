-- -----------------------------------------------------
-- General workspace rules
-- name: "Work Laptop - 1 Monitor (Home)"
-- -----------------------------------------------------

-- Workspaces 1-5 on the internal display, 6-10 on the external HDMI monitor

local function assign(from, to, monitor)
    for ws = from, to do
        hl.workspace_rule({ workspace = tostring(ws), monitor = monitor })
    end
end

assign(1, 5, "eDP-1")
assign(6, 10, "HDMI-A-1")
