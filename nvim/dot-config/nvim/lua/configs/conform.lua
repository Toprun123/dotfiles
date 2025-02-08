local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    erb = { "htmlbeautifier" },
    ["html.erb"] = { "htmlbeautifier" },
    rust = { "rustfmt" },
    go = { "gofmt" },
    javascript = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
