return {
    'CRAG666/code_runner.nvim',
    event = "BufReadPre",
    config = function()
        require('code_runner').setup({})
        vim.keymap.set('n', '<leader>rr', ':RunCode<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
    end,
}