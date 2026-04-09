return {
  'stevearc/aerial.nvim',
  keys = {
    { '<C-o>', '<cmd>AerialToggle!<CR>' },
  },
  main = 'aerial',
  opts = {
    on_attach = function(bufnr)
      vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr, unique = true })
      vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr, unique = true })
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
  },
}
