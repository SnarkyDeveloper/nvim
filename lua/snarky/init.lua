vim.g.mapleader = " "
require("snarky.lazy_init")
require("snarky.keymaps")

-- settings
vim.opt.autochdir = false
vim.g.python3_host_prog = './.venv/bin/python'
vim.opt.whichwrap:append("b,s,<,>,[,],h,l,~") -- enable soft wrapping movement for all keys