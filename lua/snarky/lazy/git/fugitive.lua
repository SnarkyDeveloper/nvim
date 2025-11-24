return {
    -- fugitive.vim
    "tpope/vim-fugitive",
    cmd = {"Git", "G" },
    keys = {
        { "<leader>gs", "<cmd>Git<cr>", desc = "Show Git Status" },
        { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" }, -- should open new buffer
    }
}