return {
  'williamboman/mason-lspconfig.nvim',
  commit = 'acb2d97a5c5e3f58156cb387fdf6035c34cd2768',
  dependencies = {
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
  },
  opts = {},
  cmd = { 'Mason' },
  config = function()
    require('mason-lspconfig').setup()
  end,
}
