return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        local autopairs = require('nvim-autopairs')
        autopairs.setup({
            check_ts = true,
            ts_config = {
                lua = { 'string', 'source' },
                javascript = { 'string', 'template_string' },
                java = false,
            },
            disable_filetype = { "TelescopePrompt", "vim" },
            disable_in_macro = false,
            disable_in_visualblock = false,
            disable_in_replace_mode = true,
            ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
            enable_moveright = true,
            enable_afterquote = true,
            enable_check_bracket_line = true,
            enable_bracket_in_quote = true,
            enable_abbr = false,
            break_undo = true,
            check_comma = true,
            map_char = {
                all = '(',
                tex = '{',
            },
            map_cr = true,
            map_bs = true,
            map_c_h = false,
            map_c_w = false,
        })
    end,
}