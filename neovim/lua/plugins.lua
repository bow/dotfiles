-- Plugins
--
-- nvim/lua/plugins.lua

-- Shared dependency versions.
local commits = {
  nvim_web_devicons = "0422a19d9aa3aad2c7e5cca167e5407b13407a9d",
  gitsigns_nvim = "bbee149e00c404aa9f7a7c248b981cde953b252a",
  plenary_nvim = "857c5ac632080dba10aae49dba902ce3abf91b35",
}

-- Plugins to load.
local specs = {
  {
    "stevearc/aerial.nvim",
    commit = "5c0df1679bf7c814c924dc6646cc5291daca8363",
    config = function(_)
      require("plugins.aerial-nvim")
    end,
  },
  {
    "goolord/alpha-nvim",
    commit = "2b3cbcdd980cae1e022409289245053f62fb50f6",
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        commit = commits.nvim_web_devicons,
      },
    },
    config = function(_)
      require("plugins.alpha-nvim")
    end,
  },
  {
    "pearofducks/ansible-vim",
    commit = "3329367d2e5f90d203c8d340c53fa83c60a1ad41",
  },
  {
    "romgrk/barbar.nvim",
    commit = "3a74402bdf04745a762de83d5c5e88e3e9b0e2e0",
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        commit = commits.nvim_web_devicons,
      },
    },
    config = function(_)
      require("plugins.barbar-nvim")
    end,
  },
  {
    "FabijanZulj/blame.nvim",
    commit = "b87b8c820e4cec06fbbd2f946b7b35c45906ee0c",
    config = function(_)
      require("plugins.blame-nvim")
    end
  },
  {
    "saadparwaiz1/cmp_luasnip",
    commit = "98d9cb5c2c38532bd9bdb481067b20fea8f32e90",
  },
  {
    "famiu/feline.nvim",
    commit = "3587f57480b88e8009df7b36dc84e9c7ff8f2c49",
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        commit = commits.nvim_web_devicons,
      },
      {
        "lewis6991/gitsigns.nvim",
        commit = commits.gitsigns_nvim,
      },
    },
    config = function(_)
      require("plugins.feline-nvim")
    end,
  },
  {
    "j-hui/fidget.nvim",
    commit = "d9ba6b7bfe29b3119a610892af67602641da778e",
    config = function(_)
      require("plugins.fidget-nvim")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    commit = commits.gitsigns_nvim,
    config = function(_)
      require("plugins.gitsigns")
    end,
  },
  {
    "morhetz/gruvbox",
    commit = "697c00291db857ca0af00ec154e5bd514a79191f",
    priority = 1000,
  },
  {
    "L3MON4D3/LuaSnip",
    commit = "66b5c2707e624dcd2cd3605676c64a2efe47e9d1",
  },
  {
    "williamboman/mason.nvim",
    commit = "8024d64e1330b86044fed4c8494ef3dcd483a67c",
    config = function(_)
      require("plugins.mason-nvim")
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    commit = "4c2cdc69d69fe00c15ae8648f7e954d99e5de3ea",
    config = function(_)
      require("plugins.mason-nvim-dap")
    end,
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    commit = "acb2d97a5c5e3f58156cb387fdf6035c34cd2768",
    config = function(_)
      require("plugins.mason-nvim-lspconfig")
    end,
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "nvimtools/none-ls.nvim",
    commit = "a5954f00ee88bcdf154e931198ec636a26a1077c",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
        commit = commits.plenary_nvim,
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    commit = "005b56001b2cb30bfa61b7986bc50657816ba4ba",
    config = function(_)
      require("plugins.indent-blankline-nvim")
    end,
  },
  {
    "windwp/nvim-autopairs",
    commit = "23320e75953ac82e559c610bec5a90d9c6dfa743",
    config = function(_)
      require("plugins.nvim-autopairs")
    end,
  },
  {
    "sindrets/diffview.nvim",
    commit = "4516612fe98ff56ae0415a259ff6361a89419b0a",
  },
  {
    "hrsh7th/nvim-cmp",
    commit = "b5311ab3ed9c846b585c0c15b7559be131ec4be9",
  },
  {
    "hrsh7th/cmp-buffer",
    commit = "b74fab3656eea9de20a9b8116afa3cfc4ec09657",
  },
  {
    "hrsh7th/cmp-path",
    commit = "e52e640b7befd8113b3350f46e8cfcfe98fcf730",
  },
  {
    "hrsh7th/cmp-cmdline",
    commit = "d126061b624e0af6c3a556428712dd4d4194ec6d",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    commit = "a8912b88ce488f411177fc8aed358b04dc246d7b",
  },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    commit = "031e6ba70b0ad5eee49fd2120ff7a2e325b17fa7",
  },
  {
    "mfussenegger/nvim-dap",
    commit = "cc77338e6e34c79f1c638f51ae4160dc9bfb05de",
    config = function(_)
      require("plugins.dap")
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    commit = "261ce649d05bc455a29f9636dc03f8cdaa7e0e2c",
    ft = "python",
  },
  {
    "rcarriga/nvim-dap-ui",
    commit = "cf91d5e2d07c72903d052f5207511bf7ecdb7122",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function(_)
      require("plugins.nvim-dap-ui")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    commit = "8c5efd1269160fc2fdf61e3d7176be5015860a8f",
    config = function(_)
      require("plugins.lspconfig")
    end,
    dependencies = { "williamboman/mason-lspconfig.nvim" },
  },
  {
    "SmiteshP/nvim-navic",
    commit = "f887d794a0f4594882814d7780980a949200a238",
    config = function(_)
      require("plugins.nvim-navic")
    end,
  },
  {
    "nvim-neotest/nvim-nio",
    commit = "21f5324bfac14e22ba26553caf69ec76ae8a7662",
  },
  {
    "nvim-tree/nvim-tree.lua",
    commit = "b0b49552c9462900a882fe772993b01d780445fe",
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        commit = commits.nvim_web_devicons,
      },
    },
    config = function(_)
      require("plugins.nvim-tree")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_)
      require("plugins.treesitter")
    end,
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    commit = "d1656221836207787b8a7969cc2dc72668c4742a",
    config = function(_)
      require("plugins.persistent-breakpoints")
    end,
  },
  {
    "luochen1990/rainbow",
    commit = "76ca1a20aa42edb5c65c19029968aad4625790dc",
  },
  {
    "nvim-telescope/telescope.nvim",
    commit = "b4da76be54691e854d3e0e02c36b0245f945c2c7",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
        commit = commits.plenary_nvim,
      },
    },
    config = function(_)
      require("plugins.telescope-nvim")
    end,
  },
  {
    "folke/todo-comments.nvim",
    commit = "304a8d204ee787d2544d8bc23cd38d2f929e7cc5",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
        commit = commits.plenary_nvim,
      },
    },
    config = function(_)
      require("plugins.todo-comments-nvim")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    commit = "9a88eae817ef395952e08650b3283726786fb5fb",
    config = function(_)
      require("plugins.toggleterm-nvim")
    end,
  },
  {
    "folke/trouble.nvim",
    commit = "85bedb7eb7fa331a2ccbecb9202d8abba64d37b3",
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        commit = commits.nvim_web_devicons,
      },
    },
    config = function(_)
      require("plugins.trouble-nvim")
    end,
  },
  {
    "ntpeters/vim-better-whitespace",
    commit = "de99b55a6fe8c96a69f9376f16b1d5d627a56e81",
    config = function(_)
      require("plugins.vim-better-whitespace")
    end,
  },
  {
    "alvan/vim-closetag",
    commit = "d0a562f8bdb107a50595aefe53b1a690460c3822",
  },
  {
    "tpope/vim-commentary",
    commit = "64a654ef4a20db1727938338310209b6a63f60c9",
  },
  {
    "easymotion/vim-easymotion",
    commit = "b3cfab2a6302b3b39f53d9fd2cd997e1127d7878",
  },
  {
    "tpope/vim-fugitive",
    commit = "d3e2b58dec75fc6012fecc82ce0d33a45ed0560e",
  },
  {
    "farmergreg/vim-lastplace",
    commit = "e58cb0df716d3c88605ae49db5c4741db8b48aa9",
  },
  {
    "kburdett/vim-nuuid",
    commit = "6abc11a7943e5777c27b6271f3b6243f426d68fd",
  },
  {
    "kshenoy/vim-signature",
    commit = "6bc3dd1294a22e897f0dcf8dd72b85f350e306bc",
  },
  {
    "dstein64/vim-startuptime",
    commit = "b6f0d93f6b8cf6eee0b4c94450198ba2d6a05ff6",
    lazy = true,
    cmd = { "StartupTime" },
  },
  {
    "tpope/vim-surround",
    commit = "3d188ed2113431cf8dac77be61b842acb64433d9",
  },

  -- Filetype-specific plugins.
  {
    "terrastruct/d2-vim",
    commit = "981c87dccb63df2887cc41b96e84bf550f736c57",
    ft = "d2",
  },
  {
    "liuchengxu/graphviz.vim",
    commit = "dbe1de334097891186e09e5616671091d89011d5",
    ft = "dot",
  },
  {
    "udalov/kotlin-vim",
    commit = "1261f851e5fb2192b3a5e1691650597c71dfce2f",
    ft = "kotlin",
  },
  {
    "jvirtanen/vim-hcl",
    commit = "7f4ac507aeaf902cd9fddd65bf0df971e43814d3",
    ft = "hcl",
  },
  {
    "Glench/Vim-Jinja2-Syntax",
    commit = "ceb0f8076ee9aa802668448cefdd782edff4f6b2",
    ft = { "jinja", "htmljinja" },
  },
  {
    "kevinoid/vim-jsonc",
    commit = "67d26459fb64236681fb600b610cd56eaeb43999",
    ft = "jsonc",
  },
  {
    "mistweaverco/kulala.nvim",
    commit = "902fc21e8a3fee7ccace37784879327baa6d1ece",
    ft = {"http", "rest"},
    opts = {
      global_keymaps = true,
      ui = {
        split_direction = "horizontal",
      },
    },
  },
  {
    "ledger/vim-ledger",
    commit = "b3e6f3dfaa922cda7771a4db20d3ae0267e08133",
    ft = "ledger",
  },
  {
    "folke/lazydev.nvim",
    commit = "2367a6c0a01eb9edb0464731cc0fb61ed9ab9d2c",
    config = function(_)
      require("plugins.lazydev")
    end,
    ft = "lua",
  },
  {
    "Mxrcon/nextflow-vim",
    commit = "77a349ad259f536c03fe2888ed9137249fa7d40e",
    ft = "nextflow",
  },
  {
    "aklt/plantuml-syntax",
    commit = "405186847a44c16dd039bb644541b4c8fbdab095",
    ft = "plantuml",
  },
  {
    "Vimjas/vim-python-pep8-indent",
    commit = "60ba5e11a61618c0344e2db190210145083c91f8",
    ft = "python",
  },
  {
    "rust-lang/rust.vim",
    commit = "889b9a7515db477f4cb6808bef1769e53493c578",
    ft = "rust",
  },
  {
    "snakemake/snakemake",
    commit = "9da571f29c3e4b2c77f8465edcb7e21c91f5feb7",
    ft = "snakemake",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/misc/vim")
    end,
  },
  {
    "cespare/vim-toml",
    commit = "1b63257680eeb65677eb1ca5077809a982756d58",
    ft = "toml",
  },
  {
    "broadinstitute/vim-wdl",
    commit = "1aaf200284b85d6075901faa8bda9ea67c6ce515",
    ft = "wdl",
  },
}

require("lazy").setup(specs)
