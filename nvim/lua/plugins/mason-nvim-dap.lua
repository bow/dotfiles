return {
  'jay-babu/mason-nvim-dap.nvim',
  dependencies = { 'williamboman/mason.nvim' },
  lazy = true,
  enabled = function() return not require('utils').in_nixos() end,
}
