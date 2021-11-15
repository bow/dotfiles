-- Plugins
--
-- nvim/lua/plugins.lua

local Plug = vim.fn['plug#']

vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')

  Plug('sheerun/vim-polyglot', {tag = 'v4.17.0'})
  Plug('neoclide/coc.nvim', {branch = 'release'})
  Plug('snakemake/snakemake', {rtp = 'misc/vim'})
  Plug('broadinstitute/vim-wdl', {commit = '1aaf200284b85d6075901faa8bda9ea67c6ce515'})

  Plug('jiangmiao/auto-pairs', {tag = 'v2.0.0'})
  Plug('ctrlpvim/ctrlp.vim', {tag = '1.81'})
  Plug('vim-airline/vim-airline', {tag = 'v0.11'})
  Plug('vim-airline/vim-airline-themes', {commit = '97cf3e6e638f936187d5f6e9b5eb1bdf0a4df256'})
  Plug('tpope/vim-commentary', {tag = 'v3.4'})
  Plug('tpope/vim-fugitive', {tag = 'v3.2'})
  Plug('nathanaelkane/vim-indent-guides', {commit = '765084d38bf102a95ab966fb06472e83fa7deff7'})
  Plug('kevinoid/vim-jsonc', {commit = '67d26459fb64236681fb600b610cd56eaeb43999'})
  Plug('farmergreg/vim-lastplace', {tag = 'v3.2.1'})
  Plug('ledger/vim-ledger', {commit = 'b3e6f3dfaa922cda7771a4db20d3ae0267e08133'})
  Plug('kburdett/vim-nuuid', {commit = '6ae845f9348921f4e436c587da6d2bbf5691c4ed'})
  Plug('kshenoy/vim-signature', {commit = '6bc3dd1294a22e897f0dcf8dd72b85f350e306bc'})
  Plug('mhinz/vim-signify', {tag = 'stable'})
  Plug('mhinz/vim-startify', {commit = '593388d3dbe7bfdcc06a714550d3253442b2fc65'})
  Plug('tpope/vim-surround', {commit = 'f51a26d3710629d031806305b6c8727189cd1935'})
  Plug('easymotion/vim-easymotion', {commit = 'd75d9591e415652b25d9e0a3669355550325263d'})
  Plug('ntpeters/vim-better-whitespace', {commit = 'c5afbe91d29c5e3be81d5125ddcdc276fd1f1322'})

  Plug('Glench/Vim-Jinja2-Syntax', {commit = 'ceb0f8076ee9aa802668448cefdd782edff4f6b2'})
  Plug('luochen1990/rainbow', {commit = '54c79a24725af3a15d3aad20f70a56c7abbd46c3'})
  Plug('morhetz/gruvbox', {commit = '040138616bec342d5ea94d4db296f8ddca17007a'})
  Plug('liuchengxu/graphviz.vim', {commit = '704aa42852f200db2594382bdf847a92fdab61fc'})

  -- nvim-tree.lua plugin
  Plug('kyazdani42/nvim-web-devicons', {commit = 'ee101462d127ed6a5561ce9ce92bfded87d7d478'})
  Plug('kyazdani42/nvim-tree.lua', {commit = 'a6c1d45dd6c26f7871f87564baf3860e0e5ac60c'})

  -- telescope plugin
  Plug('nvim-lua/plenary.nvim', {commit = '96e821e8001c21bc904d3c15aa96a70c11462c5f'})
  Plug('nvim-telescope/telescope.nvim', {commit = 'd7f09f58954495d1373f3a400596b2fed71a8d1c'})

vim.call('plug#end')
