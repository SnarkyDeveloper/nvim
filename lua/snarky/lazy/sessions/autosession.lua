return {
    "rmagatti/auto-session",
    event = "BufReadPre",

    opts = {
        suppressed_dirs = { "~/", "~/Snarky/Projects", "~/Downloads", "/" },
    },
    config = function(opts)
        require("auto-session").setup(opts)
    end,
}