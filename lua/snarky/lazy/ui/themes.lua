return {
  {
    "zaldih/themery.nvim",
    lazy = true,
    config = function()
      local themery = require("themery")
      themery.setup({
        themes = {
          { name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
          { name = "Tokyo Night Night", colorscheme = "tokyonight-night" },
          { name = "Tokyo Night Day", colorscheme = "tokyonight-day" },
          { name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
          { name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
          { name = "Catppuccin Frappe", colorscheme = "catppuccin-frappe" },
          { name = "Catppuccin Latte", colorscheme = "catppuccin-latte" },
          { name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
          { name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
          { name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus" },
          { name = "Neopywal", colorscheme = "neopywal" },
        },
        livePreview = true, -- preview themes live
      })

      -- Automatically apply last used theme
      vim.defer_fn(function()
        pcall(function() themery.loadLastTheme() end)
      end, 50) -- small delay to ensure dependent plugins are ready
    end,
  },

  -- Theme sources (lazy)
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "storm",
      light_style = "day",
      transparent = false,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      show_end_of_buffer = false,
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      variant = "wave",
      background = "dark",
      transparent = false,
    },
  },
  {
    "RedsXDD/neopywal.nvim",
    lazy = true,
    priority = 1000,
    name = "neopywal",
    opts = {
      transparent_background = false,
      terminal_colors = true,
      dim_inactive = true,
    },
    config = function(_, opts)
      require("neopywal").setup(opts)
    end,
  },
}
