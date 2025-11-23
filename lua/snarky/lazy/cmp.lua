return {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
        "L3MON4D3/LuaSnip",
        "giuxtaposition/blink-cmp-copilot",
    },
    accept = { auto_brackets = { enabled = true }, },
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    ghost_text = { enabled = true },

    keys = {
        {
            "<Tab>",
            function()
                local cmp = require("blink.cmp")
                if cmp.is_visible() then
                    cmp.accept()
                else
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
                end
            end,
            mode = "i",
            desc = "Accept completion if visible, otherwise insert Tab",
        },
    },

    opts = {
        snippets = {
            preset = "luasnip",
            expand = function(args)
                if args.body ~= nil then
                    require('luasnip').lsp_expand(args.body)
                end
            end,
        },

        sources = {
            default = {
                "copilot",
                "lsp",
                "snippets",
                "buffer",
                "path",
            },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
                },
            }
        },
    },
}
