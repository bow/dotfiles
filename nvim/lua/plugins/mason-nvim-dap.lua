return {
  'jay-babu/mason-nvim-dap.nvim',
  commit = '4c2cdc69d69fe00c15ae8648f7e954d99e5de3ea',
  dependencies = { 'williamboman/mason.nvim' },
  lazy = true,
  config = function()
    require('mason-nvim-dap').setup()
  end,
}
