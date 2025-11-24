vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

vim.keymap.set("n", "<leader>ca", function()
    require("cellular-automaton").start_animation("make_it_rain")
end)



-- ctrl + c = global copy
vim.keymap.set("n", "<C-c>", "\"+yy")
vim.keymap.set("v", "<C-c>", "\"+yy")
-- ctrl + v = global paste
vim.keymap.set("n", "<C-v>", "\"+p")
vim.keymap.set("v", "<C-v>", "\"+p")

-- control + a = select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
vim.keymap.set("i", "<C-a>", "<ESC>gg<S-v>G")

-- FTerm Toggle
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>') -- alt + i
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>') -- alt + i in terminal mode

-- Movement binds
vim.keymap.set("n", "[", "h") -- left
vim.keymap.set("n", "]", "l") -- right
vim.keymap.set("n", ";", "k") -- up
vim.keymap.set("n", "'", "j") -- down

-- switch buffers
vim.keymap.set("n", "<C-w>[", "<C-w>h")
vim.keymap.set("n", "<C-w>]", "<C-w>l")


-- alt + up/down to move line up/down
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==") -- up
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==") -- down
vim.keymap.set("i", "<A-Up>", "<ESC>:m .-2<CR>==gi") -- up
vim.keymap.set("i", "<A-Down>", "<ESC>:m .+1<CR>==gi") -- down
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv") -- up
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv") -- down