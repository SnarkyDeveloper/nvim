return {
    -- mini-diff
    "nvim-mini/mini.diff",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("mini.diff").setup({})
    end,
}