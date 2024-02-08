require('neodev').setup {
  library = {
    enabled = true,
    runtime = true,
    types = true,
    plugins = {
      'nvim-dap-ui',
      'plenary.nvim',
      'telescope.nvim',
    },
  },
}
