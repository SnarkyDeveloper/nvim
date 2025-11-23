return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot", -- Define a command to load the plugin
        event = "InsertEnter", -- Lazy-load on entering insert mode
        config = function()
        require("copilot").setup({
            -- blink handling using
            suggestion = { enabled = false  },
            panel = { enabled = false  },
        })
        end,
  },
}