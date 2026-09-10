-- -----------------------------------------------------
-- General workspace rules
-- name: "Work Laptop"
-- -----------------------------------------------------

-- Map all workspaces to the internal display

local function assign(from, to, monitor)
    for ws = from, to do
        hl.workspace_rule({ workspace = tostring(ws), monitor = monitor })
    end
end

assign(1, 5, "eDP-1")
