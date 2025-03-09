-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local servers = vim.lsp.get_clients()
local nvlsp = require "nvchad.configs.lspconfig"
local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

lspconfig.solargraph.setup {
  settings = {
    solargraph = {
      diagnostics = true,
    },
  },
}

lspconfig.cssls.setup {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
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
  capabilities = capabilities,
}

lspconfig.emmet_ls.setup {
  cmd = { "emmet-ls", "--stdio" },
  filetypes = { "html", "erb", "eruby" },
  root_dir = lspconfig.util.root_pattern(".git", "."),
  capabilities = capabilities,
  settings = {
    emmet = {
      showSuggestionsAsSnippets = true,
      variables = {},
      preferences = {},
    },
  },
}

lspconfig.bashls.setup {
  filetypes = { "sh", "bash" },
}

lspconfig.ts_ls.setup {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = true
  end,
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
  }
end
