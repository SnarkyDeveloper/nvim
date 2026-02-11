return {
  "soulis-1256/eagle.nvim",
  event = "InsertEnter",
  opts = {
    mouse_mode = false,
    keyboard_mode = true,
    show_lsp_info = false,
  },
  config = function(_, opts)
    local eagle = require("eagle")

    eagle.setup(opts)

    local function show_full_eagle()
      eagle.setup({ show_lsp_info = true })
      vim.cmd("doautocmd CursorHold")
      vim.schedule(function()
        eagle.setup({ show_lsp_info = false })
      end)
    end

    vim.keymap.set("n", "<C-k>", show_full_eagle, {
      desc = "Show full Eagle info (Docs + Errors)",
    })

    local hover_timer = vim.loop.new_timer()

    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = nil,
      callback = function()
        vim.diagnostic.open_float(nil, {
          focusable = false,
          scope = "cursor",
          border = "rounded",
          prefix = " ",
          header = "",
        })
      end,
    })

    vim.api.nvim_create_autocmd("BufLeave", {
      callback = function()
        vim.diagnostic.hide()
      end,
    })
  end,
}

