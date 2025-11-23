return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  event = "VeryLazy",
  opts = {
    display = {
      theme = "catppuccin",
      flavor = "accent",
    },
    variables = {
      problems = function()
      local n = #vim.diagnostic.get(0)
      if n == 0 then
        return ''
      elseif n == 1 then
        return '- 1 problem'
      else
        return string.format('- %d problems', n)
      end
      end,
    },
    text = {
      editing = 'Editing ${filename} ${problems}',
    }
  }
}
