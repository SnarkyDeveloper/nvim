vim.g.mapleader = " "
require("snarky.lazy_init")
require("snarky.keymaps")

-- settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.autochdir = true
vim.g.python3_host_prog = './.venv/bin/python'