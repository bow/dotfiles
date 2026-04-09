return {
  'mfussenegger/nvim-dap-python',
  enabled = function() return not require('utils').in_nixos() end,
  ft = 'python',
}
