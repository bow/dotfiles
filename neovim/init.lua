-- neovim configuration.
-- @author Wibowo Arindrarto <contact@arindrarto.dev>

vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.mapleader = ','

for _, mod in ipairs {
  'utils',
  'plugins',
  'settings',
  'keymaps',
  'colors'
} do
  require(mod)
end
