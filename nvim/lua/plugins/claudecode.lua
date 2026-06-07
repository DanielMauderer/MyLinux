return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			-- Run Claude inside a snacks terminal split that connects back to
			-- Neovim over the same WebSocket/MCP protocol the official IDE
			-- extensions use (selection, buffer and diagnostics sharing,
			-- inline diff accept/deny).
			terminal = {
				provider = "snacks",
				split_side = "right",
				split_width_percentage = 0.35,
			},
		},
		keys = {
			{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle [C]laude" },
			{ "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude [f]ocus" },
			{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Claude [r]esume" },
			{ "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Claude [C]ontinue" },
			{ "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Claude select [m]odel" },
			{ "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude add [b]uffer" },
			{ "<leader>cv", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Claude send selection" },
			{ "<leader>cy", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude accept diff ([y]es)" },
			{ "<leader>cn", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude deny diff ([n]o)" },
		},
	},
}
