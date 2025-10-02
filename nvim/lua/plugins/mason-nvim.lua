return {
  'williamboman/mason.nvim',
  commit = '8024d64e1330b86044fed4c8494ef3dcd483a67c',
  enabled = function() return not require('utils').in_nixos() end,
  opts = function(_, opts)
    return {
      ui = {
        icons = {
          package_installed = '●',
          package_pending = '⌛',
          package_uninstalled = '○',
        },
      },
      pip = {
        upgrade_pip = true,
      },
    }
  end,
}
