return {
  'nvim-lualine/lualine.nvim',
  lazy = true,
  event = 'VeryLazy',
  dependencies = { 
    'justinhj/battery.nvim', 
    'lewis6991/gitsigns.nvim' 
  },
  config = function()
    -- Check if device has a battery
    local function has_battery()
      -- Check for battery on Linux
      local handle = io.popen("ls /sys/class/power_supply/ 2>/dev/null | grep -i bat")
      if handle then
        local result = handle:read("*a")
        handle:close()
        if result and result ~= "" then
          return true
        end
      end
      
      -- Check for battery on macOS
      if vim.fn.has('mac') == 1 then
        local mac_handle = io.popen("pmset -g batt 2>/dev/null | grep -i 'InternalBattery'")
        if mac_handle then
          local mac_result = mac_handle:read("*a")
          mac_handle:close()
          if mac_result and mac_result ~= "" then
            return true
          end
        end
      end
      
      return false
    end

    local battery_available = has_battery()

    if battery_available then
      require("battery").setup({
        update_rate_seconds = 15,
        show_status_line = true,
      })
    end

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
      -- Build lualine_x components conditionally
      local lualine_x_components = {}
      
      if battery_available then
        table.insert(lualine_x_components, function() return require("battery").get_status_line() end)
      end
      
      table.insert(lualine_x_components, 'encoding')
      table.insert(lualine_x_components, 'fileformat')
      table.insert(lualine_x_components, 'filetype')

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
          lualine_x = lualine_x_components,
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
