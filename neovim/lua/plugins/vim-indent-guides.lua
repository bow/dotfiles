local g = vim.g
local au = vim.api.nvim_create_autocmd

g.indent_guides_enable_on_vim_startup = true
g.indent_guides_exclude_filetypes = {'help'}
g.indent_guides_guide_size = 4
g.indent_guides_start_level = 1
g.indent_guides_auto_colors = false
au(
  {'VimEnter', 'Colorscheme'},
  {command = [[hi IndentGuidesOdd  guibg=#1d2021 guifg=#545454 ctermbg=NONE ctermfg=grey]]}
)
au(
  {'VimEnter', 'Colorscheme'},
  {command = [[hi IndentGuidesEven guibg=#262626 guifg=#545454 ctermbg=234 ctermfg=grey]]}
)
