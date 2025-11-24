return {
    "numToStr/FTerm.nvim",
    lazy = true,
    cmd = "FTerm",
    config = function()
        require("FTerm").setup{
            border = "rounded",
            dimensions = {
                height = 0.8,
                width = 0.8,
            },
        }
        local wk = require("which-key")
        wk.add({
            { "<A-i>", "<cmd>lua require('FTerm').toggle()<cr>", desc = "Toggle Floating Terminal" },
        })
    end,
}