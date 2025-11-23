return {
    -- COMMENTS
    {
        'numToStr/Comment.nvim',
        event = "BufReadPre", -- no need to load until you open a file
        opts = {},
    },
    --folke/todo-comments.nvim
    {
        "folke/todo-comments.nvim",
        event = "BufReadPre",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    }
}