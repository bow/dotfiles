return {
  'williamboman/mason-lspconfig.nvim',
  commit = 'acb2d97a5c5e3f58156cb387fdf6035c34cd2768',
  enabled = function() return not require('utils').in_nixos() end,
  dependencies = {
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
  },
  cmd = { 'Mason' },
}
