-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

require("lspconfig").solargraph.setup {
  settings = {
    solargraph = {
      diagnostics = true,
    },
  },
}

local lspconfig = require "lspconfig"
local servers = { "gopls", "pyright", "ts_ls", "emmet_language_server" }
local nvlsp = require "nvchad.configs.lspconfig"
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.cssls.setup {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" }, -- Adjust based on your needs
  root_dir = lspconfig.util.root_pattern(".git", "."),
  settings = {
    css = {
      validate = true,
    },
    scss = {
      validate = true,
    },
    less = {
      validate = true,
    },
  },
  capabilities = capabilities, -- Use default LSP capabilities
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
  }
end
