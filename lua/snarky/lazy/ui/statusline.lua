local function parse_rgb(s)
    if not s or type(s) ~= 'string' or #s < 7 then
        return {0, 0, 0} -- fallback to black
    end
    local tail_s = s:sub(2)
    local res = {}
    for i in string.gmatch(tail_s, "%x%x") do
        table.insert(res, tonumber(i, 16))
    end
    return res
end

local function rgb_to_string(r, g, b)
    return string.format("#%02x%02x%02x", r, g, b)
end

local function checked_add(base, add)
    local result = base + add
    return math.max(0, math.min(255, result))
end

local function colormod(a, v1, v2, v3)
    return rgb_to_string(
        checked_add(a[1], v1),
        checked_add(a[2], v2),
        checked_add(a[3], v3)
    )
end

return {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = 'VeryLazy',
    config = function()
        local black = parse_rgb(vim.g.terminal_color_0 or '#1d2021') -- fallback to gruvbox dark background
        local function mode(x) 
            x = x or '#ebdbb2' -- fallback to gruvbox foreground
            return { bg = colormod(black, -6, -6, -6), fg = x, gui = 'bold' } 
        end

        local def = { 
            bg = rgb_to_string(black[1] + 15, black[2] + 15, black[3] + 15), 
            fg = vim.g.terminal_color_15 or '#ebdbb2' -- fallback to gruvbox foreground
        }
        local def_bold = vim.deepcopy(def)
        def_bold.gui = 'bold'
        local custom_gruvbox = {
            normal = {
                a = mode(vim.g.terminal_color_15 or '#ebdbb2'),
                b = def,
                c = def,
                z = def_bold,
            },
            insert = {
                a = mode(vim.g.terminal_color_14 or '#8ec07c'),
                b = def, c = def, z = def_bold,
            },
            visual = {
                a = mode(vim.g.terminal_color_11 or '#fabd2f'),
                b = def, c = def, z = def_bold,
            },
            replace = {
                a = mode(vim.g.terminal_color_9 or '#fb4934'),
                b = def, c = def, z = def_bold,
            },
            command = {
                a = mode(vim.g.terminal_color_13 or '#d3869b'),
                b = def, c = def, z = def_bold,
            },
            terminal = {
                a = mode(vim.g.terminal_color_15 or '#ebdbb2'),
                b = def, c = def, z = def_bold,
            },
            inactive = {
                a = def,
                b = def, c = def, z = def_bold,
            },
        }

        local config = require('lualine').get_config()
        config.options.theme = custom_gruvbox
        config.options.component_separators = { left = '|', right = '' }
        config.options.section_separators = { left = '', right = '' }
        config.options.icons_enabled = true
        -- config.options.globalstatus = true
        config.extensions = { 'fugitive', 'nvim-tree' }
        config.sections.lualine_b[2] = { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } }
        config.sections.lualine_c[1] = { 'filename', path = 1 }

        require('lualine').setup(config)
    end,
}