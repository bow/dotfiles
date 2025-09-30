require('aerial').setup {
  on_attach = function(bufnr)
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
  end,
  layout = {
    resize_to_content = true,
    default_direction = 'prefer_left',
  },
  autojump = true,
  filter_kind = false,
  highlight_on_hover = true,
  ignore = {
    filetypes = { 'alpha' },
  },
}
vim.keymap.set('n', '<C-o>', '<cmd>AerialToggle!<CR>')
