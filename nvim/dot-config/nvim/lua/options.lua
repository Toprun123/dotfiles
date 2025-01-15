require("nvchad.options")

-- add yours here!
local o = vim.opt
vim.api.nvim_set_keymap("x", "p", "pgvy", { noremap = true, silent = true })
vim.g.ruby_host_prog = "/usr/bin/ruby"
vim.g.loaded_ruby_provider = 1
o.mouse = ""
o.updatetime = 200
o.completeopt = { "menuone", "noselect", "noinsert" }
o.shortmess = o.shortmess + { c = true }
o.clipboard = "unnamedplus"
o.shell = "/usr/bin/fish"
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 99
o.viminfo = "'100,<50,s10,h"
o.signcolumn = "yes"
o.sessionoptions = {
	"blank",
	"buffers",
	"curdir",
	"folds",
	"help",
	"tabpages",
	"winsize",
	"winpos",
	"terminal",
	"localoptions",
}
-- Enable the list option to show invisible characters
o.list = true
-- Customize listchars to show spaces, tabs, newlines, etc.
o.listchars = {
	tab = "→ ", -- Show a right arrow for tabs
	eol = " ", -- Show a return symbol for line ends
	space = " ", -- Show a dot for spaces
	nbsp = "␣", -- Show a special symbol for non-breaking spaces
	trail = "·", -- Show a dot for trailing spaces
	lead = "·", -- Show a dot for trailing spaces
}
vim.diagnostic.config({
	virtual_text = true, -- Show diagnostics as virtual text (inline).
	signs = true, -- Show signs in the sign column.
	underline = true, -- Underline problematic code.
	update_in_insert = true, -- Update diagnostics while in insert mode.
	severity_sort = true, -- Sort diagnostics by severity.
})
o.cursorlineopt = "both" -- to enable cursorline!
