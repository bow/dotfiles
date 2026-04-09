return {
  'williamboman/mason.nvim',
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
