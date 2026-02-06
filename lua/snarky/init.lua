vim.g.mapleader = " "
require("snarky.lazy_init")
require("snarky.keymaps")

-- settings
vim.opt.autochdir = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.updatetime = 300
vim.g.python3_host_prog = './.venv/bin/python'
vim.opt.whichwrap:append("b,s,<,>,[,],h,l,~") -- enable soft wrapping movement for all keys
