-- Plugins
--
-- nvim/lua/plugins.lua

--- Clone packer.nvim if it does not yet exist.
-- @return whether packer.nvim is newly cloned or not.
local function bootstrap()
  local fn = vim.fn
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  local cloned = nil

  require('utils').check_exe {'git', '--version'}

  if fn.empty(fn.glob(install_path)) > 0 then
    cloned = fn.system {'git', 'clone', '--depth', '1', packer_url, install_path}
    vim.cmd [[packadd packer.nvim]]
  end

  return cloned ~= nil
end

--- Load the named plugin configuration.
local function load_plugin_config(name)
  require('plugins/' .. name)
end

local bootstrapped = bootstrap()
local packer = require('packer')

packer.startup(
  function(use)
    use {'wbthomason/packer.nvim'}

    use {
      'neoclide/coc.nvim',
      commit = '0fd56dd25fc36606afe2290240aecb6e6ab85092',
      config = load_plugin_config('coc-nvim'),
    }
    use {
      'vim-airline/vim-airline',
      tag = 'v0.11',
      config = load_plugin_config('nvim-tree'),
    }
    use {'vim-airline/vim-airline-themes', commit = '97cf3e6e638f936187d5f6e9b5eb1bdf0a4df256'}

    use {'jiangmiao/auto-pairs', tag = 'v2.0.0'}
    use {'tpope/vim-commentary', commit = '627308e30639be3e2d5402808ce18690557e8292'}
    use {'tpope/vim-fugitive', tag = 'v3.6'}
    use {'farmergreg/vim-lastplace', tag = 'v3.2.1'}
    use {'kburdett/vim-nuuid', commit = '6ae845f9348921f4e436c587da6d2bbf5691c4ed'}
    use {'kshenoy/vim-signature', commit = '6bc3dd1294a22e897f0dcf8dd72b85f350e306bc'}
    use {'mhinz/vim-startify', commit = '593388d3dbe7bfdcc06a714550d3253442b2fc65'}
    use {'tpope/vim-surround', commit = 'f51a26d3710629d031806305b6c8727189cd1935'}
    use {'easymotion/vim-easymotion', commit = 'd75d9591e415652b25d9e0a3669355550325263d'}
    use {'alvan/vim-closetag', commit = 'c0779ef575d5c239162f4ca3506cfb4a95d45a58'}
    use {'luochen1990/rainbow', commit = '54c79a24725af3a15d3aad20f70a56c7abbd46c3'}
    use {'morhetz/gruvbox', commit = '040138616bec342d5ea94d4db296f8ddca17007a'}
    use {
      'kyazdani42/nvim-tree.lua',
      commit = 'a6c1d45dd6c26f7871f87564baf3860e0e5ac60c',
      requires = {
        {'kyazdani42/nvim-web-devicons', commit = 'ee101462d127ed6a5561ce9ce92bfded87d7d478'},
      },
      config = load_plugin_config('nvim-tree'),
    }
    use {
      'nvim-telescope/telescope.nvim',
      commit = 'd7f09f58954495d1373f3a400596b2fed71a8d1c',
      requires = {
        {'nvim-lua/plenary.nvim', commit = '96e821e8001c21bc904d3c15aa96a70c11462c5f'},
      },
      config = load_plugin_config('telescope-nvim'),
    }
    use {
      'ntpeters/vim-better-whitespace',
      commit = 'c5afbe91d29c5e3be81d5125ddcdc276fd1f1322',
      config = load_plugin_config('vim-better-whitespace'),
    }
    use {
      'nathanaelkane/vim-indent-guides',
      commit = '765084d38bf102a95ab966fb06472e83fa7deff7',
      config = load_plugin_config('vim-indent-guides'),
    }
    use {
      'mhinz/vim-signify',
      tag = 'stable',
      config = load_plugin_config('vim-signify'),
    }
    use {
      'dstein64/vim-startuptime',
      tag = 'v4.3.0',
      opt = true,
      cmd = {'StartupTime'},
    }

    -- Filetype-specific plugins.
    use {
      'liuchengxu/graphviz.vim',
      commit = '704aa42852f200db2594382bdf847a92fdab61fc',
      ft = 'dot',
    }
    use {
      'Glench/Vim-Jinja2-Syntax',
      commit = 'ceb0f8076ee9aa802668448cefdd782edff4f6b2',
      ft = {'jinja', 'htmljinja'},
    }
    use {
      'kevinoid/vim-jsonc',
      commit = '67d26459fb64236681fb600b610cd56eaeb43999',
      ft = 'jsonc',
    }
    use {
      'ledger/vim-ledger',
      commit = 'b3e6f3dfaa922cda7771a4db20d3ae0267e08133',
      ft = 'ledger',
    }
    use {
      'Mxrcon/nextflow-vim',
      commit = '77a349ad259f536c03fe2888ed9137249fa7d40e',
      ft = 'nextflow',
    }
    use {
      'aklt/plantuml-syntax',
      commit = '405186847a44c16dd039bb644541b4c8fbdab095',
      ft = 'plantuml'
    }
    use {
      'Vimjas/vim-python-pep8-indent',
      commit = '60ba5e11a61618c0344e2db190210145083c91f8',
      ft = 'python',
    }
    use {
      'rust-lang/rust.vim',
      commit = '4aa69b84c8a58fcec6b6dad6fe244b916b1cf830',
      ft = 'rust',
    }
    use {
      'snakemake/snakemake',
      rtp = 'misc/vim',
      ft = 'snakemake',
    }
    use {
      'cespare/vim-toml',
      commit = '717bd87ef928293e0cc6cfc12ebf2e007cb25311',
      ft = 'toml',
    }
    use {
      'broadinstitute/vim-wdl',
      commit = '1aaf200284b85d6075901faa8bda9ea67c6ce515',
      ft = 'wdl',
    }

    -- Automatically set up configuration after cloning packer.nvim.
    if bootstrapped then
      packer.sync()
    end
  end
)
