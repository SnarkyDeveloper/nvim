return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = {"go", 'gomod'},
  opts = {
    goimport = "gopls",
    fillstruct = 'gopls',
    gofmt = 'gopls',
    tag_transform = false,
    test_template = "",
    test_template_dir = "",
    comment_placeholder = "   ",
    lsp_cfg = false, -- true: use non-default gopls setup specified in go/lsp.lua
    lsp_on_attach = nil, -- nil: use on_attach function defined in go/lsp.lua
    lsp_codelens = true,
    lsp_diag_hdlr = true,
    lsp_inlay_hints = {
      enable = true,
      only_current_line = false,
      show_variable_name = true,
      parameter_hints_prefix = " ",
      other_hints_prefix = "=> ",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
    },
    gopls_cmd = nil,
    gopls_remote_auto = true, -- add -remote=auto to gopls
  },

  config = function(lp, opts)
    require("go").setup(opts)
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
      require('go.format').goimports()
      end,
      group = format_sync_grp,
    })
  end,
  event = {"CmdlineEnter"},
  build = ':lua require("go.install").update_all_sync()'
}