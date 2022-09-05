-- Plugins
--
-- nvim/lua/plugins.lua

--- Load the named plugin configuration.
local function load_plugin_config(name)
  require('plugins/' .. name)
end

-- Plugins to load.
local plugins = {
  {
    'jiangmiao/auto-pairs',
    commit = '40ba005829450406e92ec6277d4308ab532dd256',
  },
  {
    'morhetz/gruvbox',
    commit = '040138616bec342d5ea94d4db296f8ddca17007a',
  },
  {
    'kyazdani42/nvim-tree.lua',
    commit = 'a6c1d45dd6c26f7871f87564baf3860e0e5ac60c',
    requires = {
      {
        'kyazdani42/nvim-web-devicons',
        commit = 'ee101462d127ed6a5561ce9ce92bfded87d7d478',
      },
    },
    config = load_plugin_config('nvim-tree'),
  },
  {
    'luochen1990/rainbow',
    commit = '54c79a24725af3a15d3aad20f70a56c7abbd46c3',
  },
  {
    'nvim-telescope/telescope.nvim',
    commit = 'd7f09f58954495d1373f3a400596b2fed71a8d1c',
    requires = {
      {
        'nvim-lua/plenary.nvim',
        commit = '96e821e8001c21bc904d3c15aa96a70c11462c5f',
      },
    },
    config = load_plugin_config('telescope-nvim'),
  },
  {
    'ntpeters/vim-better-whitespace',
    commit = 'c5afbe91d29c5e3be81d5125ddcdc276fd1f1322',
    config = load_plugin_config('vim-better-whitespace'),
  },
  {
    'alvan/vim-closetag',
    commit = 'c0779ef575d5c239162f4ca3506cfb4a95d45a58',
  },
  {
    'tpope/vim-commentary',
    commit = '627308e30639be3e2d5402808ce18690557e8292',
  },
  {
    'easymotion/vim-easymotion',
    commit = 'd75d9591e415652b25d9e0a3669355550325263d',
  },
  {
    'tpope/vim-fugitive',
    commit = '5a24c2527584e4e61a706ad7ecb3514ac7031307',
  },
  {
    'nathanaelkane/vim-indent-guides',
    commit = '765084d38bf102a95ab966fb06472e83fa7deff7',
    config = load_plugin_config('vim-indent-guides'),
  },
  {
    'farmergreg/vim-lastplace',
    commit = '48ba343c8c1ca3039224727096aae214f51327d1',
  },
  {
    'kburdett/vim-nuuid',
    commit = '6ae845f9348921f4e436c587da6d2bbf5691c4ed',
  },
  {
    'kshenoy/vim-signature',
    commit = '6bc3dd1294a22e897f0dcf8dd72b85f350e306bc',
  },
  {
    'mhinz/vim-signify',
    commit = 'abb1c89f16713728ca1096e5757ae6bd3d8cb7a6',
    config = load_plugin_config('vim-signify'),
  },
  {
    'dstein64/vim-startuptime',
    commit = '5f52ed26e0296a3e1d1453935f417e5808eefab8',
    opt = true,
    cmd = {'StartupTime'},
  },
  {
    'tpope/vim-surround',
    commit = 'f51a26d3710629d031806305b6c8727189cd1935',
  },

  -- Under review.
  {
    'neoclide/coc.nvim',
    commit = '0fd56dd25fc36606afe2290240aecb6e6ab85092',
    config = load_plugin_config('coc-nvim'),
  },
  {
    'vim-airline/vim-airline',
    commit = '507d4f394f8d6f8bf8b08a63a8596bea3884f4c3',
    requires = {
      {
        'vim-airline/vim-airline-themes',
        commit = '97cf3e6e638f936187d5f6e9b5eb1bdf0a4df256',
      },
    },
    config = load_plugin_config('vim-airline'),
  },
  {
    'mhinz/vim-startify',
    commit = '593388d3dbe7bfdcc06a714550d3253442b2fc65',
  },

  -- Filetype-specific plugins.
  {
    'liuchengxu/graphviz.vim',
    commit = '704aa42852f200db2594382bdf847a92fdab61fc',
    ft = 'dot',
  },
  {
    'Glench/Vim-Jinja2-Syntax',
    commit = 'ceb0f8076ee9aa802668448cefdd782edff4f6b2',
    ft = {'jinja', 'htmljinja'},
  },
  {
    'kevinoid/vim-jsonc',
    commit = '67d26459fb64236681fb600b610cd56eaeb43999',
    ft = 'jsonc',
  },
  {
    'ledger/vim-ledger',
    commit = 'b3e6f3dfaa922cda7771a4db20d3ae0267e08133',
    ft = 'ledger',
  },
  {
    'Mxrcon/nextflow-vim',
    commit = '77a349ad259f536c03fe2888ed9137249fa7d40e',
    ft = 'nextflow',
  },
  {
    'aklt/plantuml-syntax',
    commit = '405186847a44c16dd039bb644541b4c8fbdab095',
    ft = 'plantuml'
  },
  {
    'Vimjas/vim-python-pep8-indent',
    commit = '60ba5e11a61618c0344e2db190210145083c91f8',
    ft = 'python',
  },
  {
    'rust-lang/rust.vim',
    commit = '4aa69b84c8a58fcec6b6dad6fe244b916b1cf830',
    ft = 'rust',
  },
  {
    'snakemake/snakemake',
    commit = '9da571f29c3e4b2c77f8465edcb7e21c91f5feb7',
    rtp = 'misc/vim',
    ft = 'snakemake',
  },
  {
    'cespare/vim-toml',
    commit = '717bd87ef928293e0cc6cfc12ebf2e007cb25311',
    ft = 'toml',
  },
  {
    'broadinstitute/vim-wdl',
    commit = '1aaf200284b85d6075901faa8bda9ea67c6ce515',
    ft = 'wdl',
  },
}

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

--- Load all plugins.
local function load(plugins)
  local bootstrapped = bootstrap()
  local packer = require('packer')

  packer.startup(
    function(use)
      use 'wbthomason/packer.nvim'

      for _, plugin in ipairs(plugins) do
        use(plugin)
      end

      -- Automatically set up configuration after cloning packer.nvim.
      if bootstrapped then
        packer.sync()
      end
    end
  )
end

load(plugins)
