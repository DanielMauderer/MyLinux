return {

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	"folke/neodev.nvim",

	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},

	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = true,
				theme = "onedark",
				component_separators = "|",
				section_separators = "",
			},
		},
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	-- {
	-- 	-- Highlight, edit, and navigate code
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter-textobjects",
	-- 	},
	-- 	build = ":TSUpdate",
	-- },
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			"mfussenegger/nvim-dap-python", --optional
			{ "folke/snacks.nvim" },
		},
		ft = "python",
		branch = "main", -- This is the regexp branch, use this for the new version
		opts = {},
		keys = {
			{ ",v", "<cmd>VenvSelect<cr>" },
		},
	},

	-- Debugging
}
