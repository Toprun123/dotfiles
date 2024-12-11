return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		opts = require("configs.conform"),
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},

	"nvim-lua/plenary.nvim",

	{
		"nvchad/ui",
		config = function()
			require("nvchad")
		end,
	},

	{
		"nvchad/base46",
		lazy = true,
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"golangci-lint",
				"rust-analyzer",
				"codellb",
				"pyright",
				"rustfmt",
				"gopls",
				"gofumpt",
				-- "ruby-lsp",
			},
		},
	},

	{
		"fatih/vim-go",
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			"echasnovski/mini.pick", -- optional
		},
		config = true,
	},

	{
		"rmagatti/auto-session",
		lazy = false,
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			-- log_level = 'debug',
		},
	},

	{
		"mg979/vim-visual-multi",
		branch = "master",
		lazy = false, -- Load immediately
		config = function()
			-- vim.g.VM_maps = {
			-- 	["Add Cursor At Pos"] = "<leader>a",
			-- }
			vim.g.VM_mouse_mappings = 1
			vim.g.VM_set_statusline = 0
		end,
	},

	{
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	},

	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},

	{
		"wakatime/vim-wakatime",
		lazy = false,
	},

	"nvzone/volt", -- optional, needed for theme switcher
}
