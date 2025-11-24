return {
    {
        "kilavila/nvim-gitignore",
        lazy = true,
        event = "BufReadPre",
    },
    {
        "wintermute-cell/gitignore.nvim",
        lazy = true,
        event = "BufReadPre",
        config = function()
            require('gitignore')
            vim.keymap.set('n', '<leader>gi', ':Gitignore<CR>', { noremap = true, silent = false })
        end,
    }
}