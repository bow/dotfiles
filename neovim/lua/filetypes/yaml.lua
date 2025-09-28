return function()
  local cmd = vim.cmd
  local optl = vim.opt_local

  optl.shiftwidth = 2
  optl.tabstop = 2

  cmd [[
    au FileType yaml setl indentkeys-=<:>
  ]]
end
