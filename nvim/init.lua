-- neovim configuration.
-- @author Wibowo Arindrarto <contact@arindrarto.dev>

require 'config.filetypes'
require 'config.plugins'
require 'config.options'
require 'config.keymaps'
require 'config.colors'

local load_ok, _ = pcall(require, 'config.local')
if load_ok then
  vim.api.nvim_echo({ { 'Loaded local config', 'WarningMsg' } }, true, {})
else
  vim.api.nvim_echo({ { 'No local configs loaded', 'WarningMsg' } }, true, {})
end
