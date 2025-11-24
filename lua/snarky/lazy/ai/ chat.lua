local function get_visual_diagnostics()
    -- Get the start and end positions of the last visual selection
    -- Marks '< and '> are 1-based, but lnum in diagnostics is 0-based
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2]
    local end_line = end_pos[2]

    -- Ensure start_line is less than or equal to end_line
    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local all_diagnostics = {}
    local diagnostics_text = {}

    -- Iterate over each line in the visual range
    for lnum = start_line, end_line do
        -- Get diagnostics for the specific line (0-based for the API call)
        local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum - 1 })
        for _, diag in ipairs(diagnostics) do
            table.insert(all_diagnostics, diag)
            table.insert(diagnostics_text, string.format("Line %d: %s", lnum, diag.message))
        end
    end

    if #all_diagnostics > 0 then
        -- Write diagnostics to quickfix list without opening the menu
        local qf_items = {}
        for _, diag in ipairs(all_diagnostics) do
            table.insert(qf_items, {
                bufnr = bufnr,
                lnum = diag.lnum + 1,
                col = diag.col + 1,
                text = diag.message,
                type = diag.severity and vim.diagnostic.severity[diag.severity] or 'E',
            })
        end
        vim.fn.setqflist({}, 'r', { title = "Visual Selection Diagnostics", items = qf_items })
        return table.concat(diagnostics_text, "\n")
    else
        vim.notify("No diagnostics found in the selected range.", vim.log.levels.INFO)
        return ""
    end
end

local fix = function()
    local input = vim.fn.input("Fix (Specify the issue): ")
    local fixes = get_visual_diagnostics()
    require("CopilotChat").ask("Fix the following issues.. " .. input .. ":\n" .. fixes, {
        callback = function(response)
            return response
        end,
    })
end

local qc = function()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
        require("CopilotChat").ask("#selection" .. input, {
            callback = function(response)
                return response
            end,
        })
    end
end

return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    cmd = { "CopilotChat" },
    keys = {
        { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "Open Copilot Chat" },
    },
    config = function()
        require("CopilotChat").setup({
            window = {
                    layout = 'float',
                    width = 0.5,
                    relative = 'cursor',
                    height = 0.125,
                    border = 'rounded',
                    title = '🤖 AI Assistant',
                    zindex = 100,
                    row = 1
            },
            headers = {
                user = '⠀ 👤 User',
                assistant = '⠀ 🤖 Copilot',
                tool = '⠀ 🔧 Tools',
            },
            auto_fold = true,
            show_help = false, -- click gh to get help (which-key shows already so doesnt matter)1

            highlight_headers = true,
            separator = '⠀', -- invis char to look nicer
            error_header = '> [!ERROR] Error',
        })
        vim.keymap.set('v', '<leader>ccq', qc, { desc = "CopilotChat - Quick chat" })
        vim.keymap.set('v', '<leader>ccf', fix, { desc = "CopilotChat - Quick fix" })
    end,
}