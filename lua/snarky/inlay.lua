-- Monkey-patch inlay hint extmark to ignore 'col out of range' errors
local orig_set_extmark = vim.api.nvim_buf_set_extmark
vim.api.nvim_buf_set_extmark = function(buf, ns, line, col, opts)
  local ok, res = pcall(orig_set_extmark, buf, ns, line, col, opts)
  if not ok and tostring(res):match("Invalid 'col': out of range") then
    -- Silently ignore this error
    return nil
  end
  return res
end
