return {
	{
		"saecki/crates.nvim",
		tag = "stable",
		event = { "BufRead Cargo.toml" },
		opts = {},
		keys = {
			{
				"<leader>cv",
				function()
					require("crates").show_versions_popup()
				end,
				desc = "[C]rate [v]ersions",
				ft = "toml",
			},
			{
				"<leader>cu",
				function()
					require("crates").upgrade_crate()
				end,
				desc = "[C]rate [u]pgrade",
				ft = "toml",
			},
			{
				"<leader>cU",
				function()
					require("crates").upgrade_all_crates()
				end,
				desc = "[C]rate [U]pgrade all",
				ft = "toml",
			},
		},
	},
}
