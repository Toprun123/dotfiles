return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  "nvim-lua/plenary.nvim",
  {
    "nvchad/ui",
    config = function()
      require "nvchad"
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
    "rmagatti/auto-session",
    lazy = false,
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {},
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
  {
    "simrat39/rust-tools.nvim",
  },
  {
    "hrsh7th/nvim-cmp",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/cmp-nvim-lua",
  },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  {
    "hrsh7th/cmp-vsnip",
  },
  {
    "hrsh7th/cmp-path",
  },
  {
    "hrsh7th/cmp-buffer",
  },
  {
    "hrsh7th/vim-vsnip",
  },
  {
    "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
  {
    "m-demare/hlargs.nvim",
  },
  {
    "RRethy/vim-illuminate",
  },
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      local dropbar_api = require "dropbar.api"
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
    end,
  },
  {
    "Toprun123/PicVim",
    config = function()
      require("picvim").setup()
    end,
  },

  -- Private plugins
  -- {
  --   dir = "~/main/picvim",
  --   config = function()
  --     require("picvim").setup {}
  --   end,
  --   dev = true,
  -- },
}
