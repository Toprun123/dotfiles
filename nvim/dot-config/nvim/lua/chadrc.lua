-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig

local M = {}

M.base46 = {
  theme = "chadracula-evondev",
  theme_toggle = { "github_light", "chadracula-evondev" },
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
        return status ~= "" and "%#CodeiumHighlight# {…} " .. status:match "^%s*(.-)%s*$" .. " ❯%#StatusLine#"
          or "*"
      end,
      git = function()
        if vim.b.no_git_diff then
          return ""
        end
        local branch = vim.b.gitsigns_head or ""
        branch = branch:gsub("%s+", "")
        local status = vim.b.gitsigns_status or ""
        local parts = {
          status:match "%+([^%s]*)",
          status:match "~([^%s]*)",
          status:match "%-([^%s]*)",
        }
        if branch ~= "" then
          return "%#GitBG1#%#GitIcon#󰊢 %#GitBranchHighlight#  "
            .. branch
            .. (parts[1] and ("%#GitAddHighlight#  " .. parts[1]) or "")
            .. (parts[2] and ("%#GitModHighlight#  " .. parts[2]) or "")
            .. (parts[3] and ("%#GitDelHighlight#  " .. parts[3]) or "")
            .. "%#GitBG#%#StatusLine#"
        else
          return ""
        end
      end,
    },
  },
}

local function set_highlight(group, fg, bg)
  vim.api.nvim_set_hl(0, group, {
    fg = fg,
    bg = bg,
    bold = true,
  })
end
local statusline_bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg

if M.base46.theme == "chadracula-evondev" then
  local git_bg = "#2b2b4c"
  set_highlight("CodeiumHighlight", "#09B6A2", statusline_bg)
  set_highlight("GitBG", git_bg, statusline_bg)
  set_highlight("GitBG1", "#F05032", statusline_bg)
  set_highlight("GitIcon", "#1f2335", "#F05032")
  set_highlight("GitBranchHighlight", "#3BABFF", git_bg)
  set_highlight("GitAddHighlight", "#4fd6be", git_bg)
  set_highlight("GitModHighlight", "#ffc777", git_bg)
  set_highlight("GitDelHighlight", "#ff757f", git_bg)
else
  local git_bg = "#e1e3e5"
  set_highlight("CodeiumHighlight", "#05a795", statusline_bg)
  set_highlight("GitBG", git_bg, statusline_bg)
  set_highlight("GitBG1", "#F05032", statusline_bg)
  set_highlight("GitIcon", statusline_bg, "#F05032")
  set_highlight("GitBranchHighlight", "#008ffb", git_bg)
  set_highlight("GitAddHighlight", "#2cab94", git_bg)
  set_highlight("GitModHighlight", "#f49102", git_bg)
  set_highlight("GitDelHighlight", "#f40418", git_bg)
end
return M
