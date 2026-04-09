return {
  'williamboman/mason-lspconfig.nvim',
  enabled = function() return not require('utils').in_nixos() end,
  dependencies = {
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
  },
  cmd = { 'Mason' },
}
