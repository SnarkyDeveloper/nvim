return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- event = "VeryLazy",
    lazy = false,
    command = "Neotree",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("neo-tree").setup({})
      vim.keymap.set("n", "<leader>e", function()
        vim.cmd("Neotree toggle")
      end)
    end
  }
}
