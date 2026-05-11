return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
		config = function()
			vim.g.rustaceanvim = function()
				return {
					server = {
						capabilities = require("blink.cmp").get_lsp_capabilities(),
						settings = {
							["rust-analyzer"] = {
								checkOnSave = true,
							check = { command = "clippy" },
								cargo = { allFeatures = true },
								procMacro = { enable = true },
								diagnostics = {
									enable = true,
									experimental = { enable = true },
								},
							},
						},
					},
					dap = {
						adapter = {
							type = "executable",
							command = "gdb",
							args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
							name = "gdb",
						},
					},
				}
			end
		end,
		keys = {
			{
				"<leader>cr",
				function()
					vim.cmd.RustLsp("runnables")
				end,
				desc = "[R]ust runnables",
				ft = "rust",
			},
			{
				"<leader>cD",
				function()
					vim.cmd.RustLsp("debuggables")
				end,
				desc = "[D]ebug Rust target",
				ft = "rust",
			},
			{
				"<leader>cE",
				function()
					vim.cmd.RustLsp("expandMacro")
				end,
				desc = "[E]xpand macro",
				ft = "rust",
			},
			{
				"<leader>ce",
				function()
					vim.cmd.RustLsp("explainError")
				end,
				desc = "[E]xplain error",
				ft = "rust",
			},
		},
	},
}
