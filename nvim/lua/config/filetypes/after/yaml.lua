return function()
  local optl = vim.opt_local

  optl.shiftwidth = 2
  optl.tabstop = 2

  vim.cmd [[
    au FileType yaml setl indentkeys-=<:>
  ]]
end
