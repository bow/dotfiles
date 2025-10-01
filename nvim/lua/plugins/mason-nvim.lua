if require("utils").in_nixos() then
  return {}
end

return {
  'williamboman/mason.nvim',
  commit = '8024d64e1330b86044fed4c8494ef3dcd483a67c',
  config = function()
    require('mason').setup {
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
