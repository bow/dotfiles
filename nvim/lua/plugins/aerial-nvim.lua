return {
  'stevearc/aerial.nvim',
  commit = '5c0df1679bf7c814c924dc6646cc5291daca8363',
  keys = { '<C-o>' },
  main = 'aerial',
  opts = function(_, opts)
    vim.keymap.set('n', '<C-o>', '<cmd>AerialToggle!<CR>')
    return {
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
  end,
}
