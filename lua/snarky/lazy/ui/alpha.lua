local banner = {
  " $$$$$$\\                                $$\\                 $$$$$$$\\                      ",
  "$$  __$$\\                               $$ |                $$  __$$\\                     ",
  "$$ /  \\__|$$$$$$$\\   $$$$$$\\   $$$$$$\\  $$ |  $$\\ $$\\   $$\\ $$ |  $$ | $$$$$$\\ $$\\    $$\\ ",
  "\\$$$$$$\\  $$  __$$\\  \\____$$\\ $$  __$$\\ $$ | $$  |$$ |  $$ |$$ |  $$ |$$  __$$\\\\$$\\  $$  |",
  " \\____$$\\ $$ |  $$ | $$$$$$$ |$$ |  \\__|$$$$$$  / $$ |  $$ |$$ |  $$ |$$$$$$$$ |\\$$\\$$  / ",
  "$$\\   $$ |$$ |  $$ |$$  __$$ |$$ |      $$  _$$<  $$ |  $$ |$$ |  $$ |$$   ____| \\$$$  /  ",
  "\\$$$$$$  |$$ |  $$ |\\$$$$$$$ |$$ |      $$ | \\$$\\ \\$$$$$$$ |$$$$$$$  |\\$$$$$$$\\   \\$  /   ",
  " \\______/ \\__|  \\__| \\_______|\\__|      \\__|  \\__| \\____$$ |\\_______/  \\_______|   \\_/    ",
  "                                                  $$\\   $$ |                              ",
  "                                                  \\$$$$$$  |                              ",
  "                                                   \\______/                               ",
}

local banner_small = {
  " $$$$$$\\                                $$\\                 ",
  "$$  __$$\\                               $$ |                ",
  "$$ /  \\__|$$$$$$$\\   $$$$$$\\   $$$$$$\\  $$ |  $$\\ $$\\   $$\\ ",
  "\\$$$$$$\\  $$  __$$\\  \\____$$\\ $$  __$$\\ $$ | $$  |$$ |  $$ |",
  " \\____$$\\ $$ |  $$ | $$$$$$$ |$$ |  \\__|$$$$$$  / $$ |  $$ |",
  "$$\\   $$ |$$ |  $$ |$$  __$$ |$$ |      $$  _$$<  $$ |  $$ |",
  "\\$$$$$$  |$$ |  $$ |\\$$$$$$$ |$$ |      $$ | \\$$\\ \\$$$$$$$ |",
  " \\______/ \\__|  \\__| \\_______|\\__|      \\__|  \\__| \\____$$ |",
  "                                                  $$\\   $$ |",
  "                                                  \\$$$$$$  |",
  "                                                   \\______/ ",
}

return {
  "goolord/alpha-nvim",
  lazy = true,
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    
    -- Dynamic padding based on terminal height
    local function get_centered_padding()
      local total_height = vim.o.lines
      local height = vim.o.lines
      local width = vim.o.columns
      
      -- Adjust content height based on banner size
      local content_height = (height < 30 or width < 80) and 25 or 30
      local padding = math.max(1, math.floor((total_height - content_height) / 2))
      return padding
    end

    -- Main banner header with responsive sizing
    local header = {
      type = "text",
      val = (function()
        local height = vim.o.lines
        local width = vim.o.columns
        
        -- Use small banner if terminal is too small
        if height < 30 or width < 80 then
          return banner_small
        end
        return banner
      end)(),
      opts = {
        position = "center",
        hl = "Label",
      },
    }

    -- Time header with greeting
    local time_header = (function()
      local hour = tonumber(os.date("%H"))
      local current_time = os.date("%I:%M %p")
      local greeting = hour >= 18 and "Good evening" or hour >= 12 and "Good afternoon" or "Good morning"
      local sym = (hour >= 18 or hour < 4) and "" or "󰖨"
      local user = vim.fn.expand("$USER")
      return {
        type = "text",
        val = " " .. greeting .. ", " .. user .. "! " .. "It's currently " .. current_time .. " " .. sym,
        opts = {
          position = "center",
          hl = "Number",
        },
      }
    end)()

    -- Buttons
    local buttons = {
      type = "group",
      val = {
        time_header,
        { type = "padding", val = 1 },
        { type = "button", val = "󰈞  Find File", on_press = function() vim.cmd("Telescope find_files") end, opts = { shortcut = "f", position = "center", cursor = 3, width = 50, align_shortcut = "right", hl_shortcut = "Keyword" } },
        { type = "button", val = "  New File", on_press = function() vim.cmd("ene!") end, opts = { shortcut = "n", position = "center", cursor = 3, width = 50, align_shortcut = "right", hl_shortcut = "Keyword" } },
        { type = "button", val = "  Pallete", on_press = function() vim.cmd("<cmd>themery<cr>") end, opts = { shortcut = "p", position = "center", cursor = 3, width = 50, align_shortcut = "right", hl_shortcut = "Keyword" } },
        { type = "button", val = "  Recent files", on_press = function() vim.cmd("Telescope oldfiles") end, opts = { shortcut = "r", position = "center", cursor = 3, width = 50, align_shortcut = "right", hl_shortcut = "Keyword" } },
        { type = "button", val = "󰒲  Lazy", on_press = function() vim.cmd("Lazy") end, opts = { shortcut = "l", position = "center", cursor = 3, width = 50, align_shortcut = "right", hl_shortcut = "Keyword" } },
        { type = "button", val = "󰅖  Quit", on_press = function() vim.cmd("quit") end, opts = { shortcut = "q", position = "center", cursor = 3, width = 50, align_shortcut = "right", hl_shortcut = "Keyword" } },
      },
      opts = {
        spacing = 1,
      },
    }

    local initPlugins = require("lazy").stats().loaded;

    -- Lazy stats footer
    local footer = {
      type = "text",
      val = { "", "󱐋 Calculating startup time..." },
      opts = {
        position = "center",
        hl = "SpecialComment",
      },
    }

    local function update_footer()
      local lazy_ok, lazy = pcall(require, "lazy")
      if not lazy_ok then
        footer.val = { "", "󰒲  Lazy not loaded" }
        return
      end
      local stats = lazy.stats()
      local text = string.format("󰒲  Lazy loaded %d/%d plugins in %.2fms", initPlugins, stats.count, stats.startuptime)
      footer.val = { "", text }
      vim.cmd("AlphaRedraw")
    end

    local layout = {
      { type = "padding", val = get_centered_padding() },
      header,
      { type = "padding", val = 2 },
      buttons,
      { type = "padding", val = 1 },
      footer,
    }

    -- Set up the alpha dashboard
    alpha.setup({
      layout = layout,
      opts = {
        margin = 5,
      },
    })

    -- Update footer after dashboard loads to show real startup time
    vim.defer_fn(update_footer, 100)

    -- Refresh layout on window resize
    vim.api.nvim_create_autocmd("VimResized", {
      pattern = "*",
      callback = function()
        -- Only refresh if we're in an alpha buffer
        if vim.bo.filetype == "alpha" then
          vim.defer_fn(function()
            -- Recreate the header with new banner based on current size
            local height = vim.o.lines
            local width = vim.o.columns
            header.val = (height < 30 or width < 80) and banner_small or banner
            vim.cmd("AlphaRedraw")
          end, 100)
        end
      end,
      desc = "Refresh alpha dashboard on resize"
    })

    -- Set up keybinds for the alpha buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        local opts = { buffer = 0, silent = true, nowait = true }
        vim.keymap.set("n", "f", function() vim.cmd("Telescope find_files") end, opts)
        vim.keymap.set("n", "n", function() vim.cmd("ene!") end, opts)
        vim.keymap.set("n", "p", function() vim.cmd("Themery") end, opts)
        vim.keymap.set("n", "r", function() vim.cmd("Telescope oldfiles") end, opts)
        vim.keymap.set("n", "l", function() vim.cmd("Lazy") end, opts)
        vim.keymap.set("n", "q", function() vim.cmd("quit") end, opts)
      end,
    })
  end,
}
