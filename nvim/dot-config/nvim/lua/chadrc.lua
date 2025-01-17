-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig

local M = {}

M.base46 = {
	theme = "chadracula-evondev",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

M.ui = {
	statusline = {
		theme = "default",
		separator_style = "round",
		order = {
			"mode",
			"file",
			"codeium",
			"%=",
			"git",
			"%=",
			"lsp_msg",
			"diagnostics",
			"lsp",
			"cwd",
			"cursor",
		},
		modules = {
			codeium = function()
				local status = vim.api.nvim_call_function("codeium#GetStatusString", {})
				return status ~= ""
						and "%#CodeiumHighlight# {…} " .. status:match("^%s*(.-)%s*$") .. " ❯%#StatusLine#"
					or "*"
			end,
			git = function()
				local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
				branch = branch:gsub("%s+", "")
				local status = vim.b.gitsigns_status or ""
				local parts = {
					status:match("%+([^%s]*)"),
					status:match("~([^%s]*)"),
					status:match("%-([^%s]*)"),
				}
				if status ~= "" then
					return "%#GitBranchHighlight#  "
						.. branch
						.. (parts[1] and ("%#GitAddHighlight#  " .. parts[1]) or "")
						.. (parts[2] and ("%#GitModHighlight#  " .. parts[2]) or "")
						.. (parts[3] and ("%#GitDelHighlight#  " .. parts[3]) or "")
						.. "%#StatusLine#"
				else
					return ""
				end
			end,
		},
	},
}

local statusline_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
vim.api.nvim_set_hl(0, "CodeiumHighlight", {
	fg = "#09B6A2",
	bg = statusline_hl.bg,
	bold = true,
})
vim.api.nvim_set_hl(0, "GitBranchHighlight", {
	fg = "#FF8800",
	bg = statusline_hl.bg,
	bold = true,
})
vim.api.nvim_set_hl(0, "GitAddHighlight", {
	fg = "#4fd6be",
	bg = statusline_hl.bg,
	bold = true,
})
vim.api.nvim_set_hl(0, "GitModHighlight", {
	fg = "#ffc777",
	bg = statusline_hl.bg,
	bold = true,
})
vim.api.nvim_set_hl(0, "GitDelHighlight", {
	fg = "#ff757f",
	bg = statusline_hl.bg,
	bold = true,
})

return M
