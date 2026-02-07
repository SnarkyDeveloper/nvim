return {
  'nvim-lualine/lualine.nvim',
  lazy = true,
  event = 'VeryLazy',
  dependencies = { 
    'justinhj/battery.nvim', 
    'lewis6991/gitsigns.nvim' 
  },
  config = function()
    require("battery").setup({
      update_rate_seconds = 15,
      show_status_line = true,
    })

    local function git_blame()
      local blame_info = vim.b.gitsigns_blame_line_dict
      if not blame_info or vim.tbl_isempty(blame_info) then return "" end

      local is_uncommitted = blame_info.author == "Not Committed Yet"
      local author = is_uncommitted and "You" or blame_info.author
      
      local date_str
      if is_uncommitted then
        date_str = "Today"
      else
        date_str = os.date("%m/%d/%y", blame_info.author_time)
      end

      return string.format(" %s (%s)", author, date_str)
    end

    local function setup_lualine()
      require('lualine').setup({
        options = {
          theme = 'auto', -- should work when themery udpates it lol
          component_separators = { left = '|', right = '' },
          section_separators = { left = '', right = '' },
          icons_enabled = true,
        },
        sections = {
          lualine_b = {
            'branch',
            { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } }
          },
          lualine_c = {
            { 'filename', path = 1 },
            { git_blame, cond = function() return vim.b.gitsigns_blame_line_dict ~= nil end }
          },
          lualine_x = { 
            function() return require("battery").get_status_line() end,
            'encoding', 
            'fileformat', 
            'filetype' 
          },
        },
        extensions = { 'fugitive', 'nvim-tree' }
      })
    end

    -- init line
    setup_lualine()

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("LualineReload", { clear = true }),
      callback = function()
        require('lualine').refresh()
      end,
    })
  end,
}
