require("nvchad.mappings")

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Normal mode: Move line up/down
map("n", "<A-Up>", ":move-2<CR>", { silent = true })
map("n", "<A-Down>", ":move+1<CR>", { silent = true })
-- Visual mode: Move selected lines up/down
map("x", "<A-Up>", ":move '<-2<CR>gv", { silent = true })
map("x", "<A-Down>", ":move '>+1<CR>gv", { silent = true })

map("n", "<leader>a", "zo", { silent = true })
map("n", "<leader>z", "zc", { silent = true })

-- Custom commands
vim.api.nvim_create_user_command("W", "write", {})
vim.api.nvim_create_user_command("Q", "quit", {})
