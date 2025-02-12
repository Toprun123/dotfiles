return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
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
      },
    },
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      pre_save_cmds = { "NvimTreeClose" },
      save_extra_cmds = {
        "NvimTreeOpen",
      },
      post_restore_cmds = {
        "NvimTreeOpen",
      },
    },
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
  "nvzone/volt",
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
      vim.keymap.set("i", "<M-right>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, noremap = true })
      vim.keymap.set("i", "<M-left>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, noremap = true })
      vim.keymap.set("i", "<C-down>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, noremap = true })
      vim.keymap.set("i", "<M-space>", function()
        return vim.fn["codeium#Complete"]()
      end, { expr = true, noremap = true })
      vim.keymap.set("i", "<C-k>", function()
        return vim.fn["codeium#AcceptNextWord"]()
      end, { expr = true, noremap = true })
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
    "itchyny/vim-cursorword",
    event = "BufEnter",
    config = function() end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("ufo").setup {
        provider_selector = function(_, _, _)
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = ("  󰁂 %d lines "):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              table.insert(newVirtText, { chunkText, chunk[2] })
              curWidth = curWidth + vim.fn.strdisplaywidth(chunkText)
              if curWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end,
        fold_symbols = {
          open = "",
          close = "",
        },
      }
    end,
  },
  {
    "Toprun123/PicVim",
    config = function()
      require("picvim").setup()
    end,
  },
  {
    "Toprun123/UdiVim",
    config = function()
      require("udivim").setup()
    end,
  },

  -- Private plugins
  -- {
  --   dir = "~/main/PicVim",
  --   config = function()
  --     require("picvim").setup {}
  --   end,
  --   dev = true,
  -- },
  -- {
  --   dir = "~/main/UdiVim",
  --   config = function()
  --     require("udivim").setup {}
  --   end,
  --   dev = true,
  -- },
}
