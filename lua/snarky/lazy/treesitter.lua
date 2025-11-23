return {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "rust",
            "typescript",
            "yaml",
            "go"
        },

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true }, -- auto-indent based on lang (like vsc)
        autoinstall = { enable = true }
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}