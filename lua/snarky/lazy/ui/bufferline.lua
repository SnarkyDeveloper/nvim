return {
    "akinsho/bufferline.nvim",
    version = "*",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("bufferline").setup({
            options = {
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                        separator = true,
                    },
                },
                show_buffer_close_icons = true,
                show_close_icon = true,
                -- separator_style = "slant",
                
                themeable = true,
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    if context.buffer:current() then
                        return ''
                    end
                    local sym = level == "error" and " "
                    or (level == "warning" and " " or " ")
                    return sym .. count
                end,    
                indicator = {
                    style = "underline",
                },
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { 'close' },
                },
            },
        })
        -- alt 1-9 go to buffer
        for i = 1, 9 do
            vim.keymap.set("n", "<M-" .. i .. ">", function()
                require("bufferline").go_to_buffer(i)
            end, { desc = "Go to buffer " .. i })
        end

        -- alt + w to close
        vim.keymap.set("n", "<M-w>", function()
            vim.cmd("bd")
        end, { desc = "Close buffer" })

        -- alt + s to save
        vim.keymap.set("n", "<M-s>", function()
            vim.cmd("w")
        end, { desc = "Save buffer" })
    end,
}