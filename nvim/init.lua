-- neovim configuration.
-- @author Wibowo Arindrarto <contact@arindrarto.dev>

require 'config.filetypes'
require 'config.plugins'
require 'config.options'
require 'config.keymaps'
require 'config.colors'

local load_ok, _ = pcall(require, 'config.local')
