return {
    {
        'dmmulroy/ts-error-translator.nvim',
        ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'tsx' },
        lazy = true,
        config = function()
            require('ts-error-translator').setup({
                auto_attach = true,
                  servers = {
                    "astro",
                    "svelte",
                    "ts_ls",
                    "typescript-tools",
                    "volar",
                    "vtsls",
                },
            })
        end
    },
    {
        "pmizio/typescript-tools.nvim",
        ft = { "typescript", "typescriptreact", "tsx" },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {}
    },
    {
        "dmmulroy/tsc.nvim",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "tsx" },
        config = function()
            require("tsc").setup({
                auto_start_watch_mode = true,
                use_trouble_qflist = true,
                use_diagnostics = true,
                flags = {
                    watch = true,
                }
            })
        end,
    }
}