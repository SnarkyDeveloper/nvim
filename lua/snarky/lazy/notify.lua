return {
    "rcarriga/nvim-notify",
    lazy = true,
    -- autoloaded by noice
    opts = {
        render = "compact",
        stages = "fade",
        timeout = 3000,
    },

    config = function(_, opts)
        require("notify").setup(opts)
    end,
}