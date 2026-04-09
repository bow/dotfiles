return {
  'folke/lazydev.nvim',
  ft = 'lua',
  main = 'lazydev',
  opts = {
    library = {
      plugins = {
        'nvim-dap-ui',
        'plenary.nvim',
        'telescope.nvim',
      },
    },
  },
}
