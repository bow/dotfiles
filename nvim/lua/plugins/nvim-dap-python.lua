return {
  'mfussenegger/nvim-dap-python',
  commit = '261ce649d05bc455a29f9636dc03f8cdaa7e0e2c',
  enabled = function() return not require('utils').in_nixos() end,
  ft = 'python',
}
