-- -----------------------------------------------------
-- General workspace rules
-- name: "Default"
-- -----------------------------------------------------

-- Workspaces 1-5 on DP-3, 6-10 on DP-2

local function assign(from, to, monitor)
    for ws = from, to do
        hl.workspace_rule({ workspace = tostring(ws), monitor = monitor })
    end
end

assign(1, 5, "DP-3")
assign(6, 10, "DP-2")

-- Example rules (see https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/)
-- hl.workspace_rule({ workspace = "3", no_rounding = true, decorate = false })
-- hl.workspace_rule({ workspace = "8", border_size = 8 })
-- hl.workspace_rule({ workspace = "name:Hello", monitor = "DP-1", default = true })
-- hl.workspace_rule({ workspace = "5", on_created_empty = "[float] firefox" })
-- hl.workspace_rule({ workspace = "special:scratchpad", on_created_empty = "foot" })
