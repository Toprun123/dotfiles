require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<A-Up>", ":move-2<CR>", { noremap = true, silent = true })
map("n", "<A-Down>", ":move+1<CR>", { noremap = true, silent = true })
map("x", "<A-Up>", ":move '<-2<CR>gv", { noremap = true, silent = true })
map("x", "<A-Down>", ":move '>+1<CR>gv", { noremap = true, silent = true })

map("n", "'", "<nop>", { noremap = true, silent = true })
map("n", '"', "<nop>", { noremap = true, silent = true })
map("n", '"', "zo", { noremap = true, silent = true })
map("n", "'", "zc", { noremap = true, silent = true })
map("n", "c", ":Huefy<CR>", { noremap = true, silent = true })

map("n", ">", ">>", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })
map("n", "<", "<<", { noremap = true, silent = true })
map("v", "<", "<gv", { noremap = true, silent = true })
map("n", ".", ">>", { noremap = true, silent = true })
map("v", ".", ">gv", { noremap = true, silent = true })
map("n", ",", "<<", { noremap = true, silent = true })
map("v", ",", "<gv", { noremap = true, silent = true })

map("n", "[", "<C-w>W", { noremap = true, silent = true })
map("n", "]", "<C-w>w", { noremap = true, silent = true })

map("n", "=", "10j", { noremap = true, silent = true })
map("n", "-", "10k", { noremap = true, silent = true })

map("n", "z", "u", { noremap = true, silent = true })
map("n", "d", "<C-r>", { noremap = true, silent = true })
map("n", "u", "<nop>", { noremap = true, silent = true })
map("n", "<C-r>", "<nop>", { noremap = true, silent = true })

map("n", "k", ":nohls<CR>", { noremap = true, silent = true })
map("n", "w", "b", { noremap = true, silent = true })
map("n", "u", "ggVG", { noremap = true, silent = true })

map("n", "s", function()
	local char = vim.fn.nr2char(vim.fn.getchar())
	local status, _ = pcall(function()
		vim.cmd("normal! '" .. char)
	end)
	if not status then
		return
	end
end, { noremap = true })

map("n", "n", function()
	vim.cmd("delmarks " .. vim.fn.nr2char(vim.fn.getchar()))
end, { noremap = true })

map({ "n", "t" }, "q", function()
	require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { noremap = true })

map("n", "l", function()
	local line = vim.fn.input("Go to line: ")
	if tonumber(line) then
		vim.api.nvim_command(line)
	else
		print("Invalid line number")
	end
end, { noremap = true })
