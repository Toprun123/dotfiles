vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.loader.enable()

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins

require("lazy").setup({
  -- Plugin configurations
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  {
    import = "plugins",
  },
}, lazy_config)

-- Load files
require "options"
require "nvchad.autocmds"
vim.schedule(function()
  require "mappings"
end)

-- Autocommands
local autocmd = vim.api.nvim_create_autocmd
autocmd("VimEnter", {
  command = ":silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0 margin=0",
})
-- autocmd("VimEnter", {
-- 	command = "NvimTreeToggle",
-- })
autocmd("VimLeavePre", {
  command = ":silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=8 margin=0",
})
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})
autocmd("BufWinLeave", {
  pattern = "*", -- Matches all buffers
  callback = function()
    -- Check if the buffer is a file (not a help, terminal, etc.)
    if vim.fn.expand "%:p" ~= "" then
      -- Only call mkview if there is a valid file name
      vim.cmd "mkview"
    end
  end,
})
autocmd("BufWinEnter", {
  command = "silent! loadview",
})
autocmd("CursorHold", {
  pattern = "*", -- Apply to all files
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})
autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd "luafile ~/.config/nvim/lua/chadrc.lua"
  end,
})

-- Autocmd for LSP
autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    -- Displays hover information about the symbol under the cursor
    bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
    -- Jump to the definition
    bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
    -- Jump to declaration
    bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
    -- Lists all the implementations for the symbol under the cursor
    bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
    -- Jumps to the definition of the type symbol
    bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
    -- Lists all the references
    bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
    -- Displays a function's signature information
    bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
    -- Renames all references to the symbol under the cursor
    bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
    -- Selects a code action available at the current cursor position
    bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    -- Show diagnostics in a floating window
    bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
    -- Move to the previous diagnostic
    bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
    -- Move to the next diagnostic
    bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
  end,
})

-- Cmp stuff
require("luasnip.loaders.from_vscode").lazy_load()
local cmp = require "cmp"
local luasnip = require "luasnip"
local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup {
  -- preselect = cmp.PreselectMode.None,
  -- completion = {
  -- 	completeopt = "noselect",
  -- },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = "path" },
    { name = "nvim_lsp", keyword_length = 1 },
    { name = "buffer", keyword_length = 3 },
    { name = "luasnip", keyword_length = 2 },
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "menu", "abbr", "kind" },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = "λ",
        luasnip = "⋗",
        buffer = "Ω",
        path = "🖫",
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
    ["<Down>"] = cmp.mapping.select_next_item(select_opts),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping.confirm { select = true },
    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<C-f>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-b>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      local col = vim.fn.col "." - 1
      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
        fallback()
      else
        cmp.complete()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
}

-- Treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "rust", "toml", "python", "go" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ident = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
}

-- Rust tools stuff
local rt = require "rust-tools"
rt.setup {
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
}

-- Tree-sitter
require("treesitter-context").setup {
  enable = true, -- Enable the context feature
  max_lines = 0, -- Set the maximum number of lines for context (0 for unlimited)
}

-- Nvim-tree

require("nvim-tree").setup {
  git = {
    ignore = false, -- Set this to false to show git-ignored files
  },
}

-- require("provider.ruby.health").check()
pcall(vim.cmd, "aunmenu PopUp.How-to\\ disable\\ mouse")
pcall(vim.cmd, "aunmenu PopUp.-1-")

function ReloadIt(module_name)
  -- Unload the module from package.loaded so it will be reloaded
  package.loaded[module_name] = nil
  -- Re-require the module to reload it
  require(module_name)
end
