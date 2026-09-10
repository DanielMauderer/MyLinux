return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		keys = {
			{ "<leader>gc", "<cmd>DiffviewOpen --merge-tool<cr>", desc = "[G]it [c]onflicts" },
			{ "<leader>gC", "<cmd>DiffviewClose<cr>", desc = "[G]it diffview [C]lose" },
		},
		opts = {
			keymaps = {
				diff3 = {
					{
						"n",
						"<leader>co",
						function()
							require("diffview.actions").conflict_choose("ours")
						end,
						{ desc = "Choose OURS" },
					},
					{
						"n",
						"<leader>ct",
						function()
							require("diffview.actions").conflict_choose("theirs")
						end,
						{ desc = "Choose THEIRS" },
					},
					{
						"n",
						"<leader>cb",
						function()
							require("diffview.actions").conflict_choose("base")
						end,
						{ desc = "Choose BASE" },
					},
					{
						"n",
						"<leader>ca",
						function()
							require("diffview.actions").conflict_choose("all")
						end,
						{ desc = "Choose ALL" },
					},
					{
						"n",
						"dx",
						function()
							require("diffview.actions").conflict_choose("none")
						end,
						{ desc = "Delete conflict region" },
					},
				},
			},
		},
	},
}
