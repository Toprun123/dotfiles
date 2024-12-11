-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
require("lspconfig").solargraph.setup({})

local lspconfig = require("lspconfig")
local servers = { "html", "cssls", "gopls", "pyright", "solargraph" }
local nvlsp = require("nvchad.configs.lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lsps with default config
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = lsp_capabilities,
	})
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
