return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot", -- lazy load
    event = "InsertEnter", -- insert lazy too
    config = function()
    require("copilot").setup({
        -- blink handling using
        suggestion = { enabled = false  },
        panel = { enabled = false  },
    })
    end,
}