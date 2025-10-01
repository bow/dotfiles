return {
  'folke/lazydev.nvim',
  commit = '2367a6c0a01eb9edb0464731cc0fb61ed9ab9d2c',
  ft = 'lua',
  config = function()
    require('lazydev').setup {
      library = {
        plugins = {
          'nvim-dap-ui',
          'plenary.nvim',
          'telescope.nvim',
        },

      }
    }
  end,
}
