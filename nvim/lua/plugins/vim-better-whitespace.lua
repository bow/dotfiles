return {
  'ntpeters/vim-better-whitespace',
  commit = 'de99b55a6fe8c96a69f9376f16b1d5d627a56e81',
  init = function()
    local g = vim.g

    g.better_whitespace_enabled = true
    g.better_whitespace_ctermcolor = 'red'
    g.better_whitespace_guicolor = '#cc241d'
  end,
}
