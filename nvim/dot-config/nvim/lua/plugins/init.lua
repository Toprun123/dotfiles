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

	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"Exafunction/codeium.vim",
		config = function()
			vim.keymap.set("i", "<C-up>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, noremap = true })
			-- Cycle completions forward with <C-left>
			vim.keymap.set("i", "<C-right>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, noremap = true })
			-- Cycle completions backward with <C-right>
			vim.keymap.set("i", "<C-left>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, noremap = true })
			-- Accept suggestion with <C-space>
			vim.keymap.set("i", "<C-down>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, noremap = true })
			-- Manually trigger suggestion with <M-space>
			vim.keymap.set("i", "<M-space>", function()
				return vim.fn["codeium#Complete"]()
			end, { expr = true, noremap = true })
			-- Accept next word from suggestion with <C-k>
			vim.keymap.set("i", "<C-k>", function()
				return vim.fn["codeium#AcceptNextWord"]()
			end, { expr = true, noremap = true })
			-- Accept next line from suggestion with <C-l>
			vim.keymap.set("i", "<C-l>", function()
				return vim.fn["codeium#AcceptNextLine"]()
			end, { expr = true, noremap = true })
		end,
	},
}
