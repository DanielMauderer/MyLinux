-- -----------------------------------------------------
-- General workspace rules
-- name: "Work Laptop - 2 Monitors"
-- -----------------------------------------------------

-- Workspaces 1-5 on DP-5, 6-10 on DP-6 (internal eDP-1 unused)

local function assign(from, to, monitor)
    for ws = from, to do
        hl.workspace_rule({ workspace = tostring(ws), monitor = monitor })
    end
end

assign(1, 5, "DP-5")
assign(6, 10, "DP-6")
