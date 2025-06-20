-- Plugins
--
-- nvim/lua/plugins.lua

-- Shared dependency versions.
local commits = {
  nvim_web_devicons = "140edfcf25093e8b321d13e154cbce89ee868ca0",
  gitsigns_nvim = "6ef8c54fb526bf3a0bc4efb0b2fe8e6d9a7daed2",
  plenary_nvim = "96e821e8001c21bc904d3c15aa96a70c11462c5f",
}

-- Plugins to load.
local specs = {
  {
    "stevearc/aerial.nvim",
    commit = "9ebc13583cff447f5493a63e99dfca526b3c3088",
    config = function(_)
      require("plugins.aerial-nvim")
    end,
  },
  {
    "goolord/alpha-nvim",
    commit = "09e5374465810d71c33e9b097214adcdebeee49a",
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
    commit = "93798e8c89c441d29d4678da0c0d5e1429eb43b0",
  },
  {
    "romgrk/barbar.nvim",
    commit = "e5f1393350cf842389be289c03885b92ab29ffb3",
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
    commit = "39bb4cda9e658d053a43919b10ca52c0a4d738e1",
    config = function(_)
      require("plugins.blame-nvim")
    end
  },
  {
    "saadparwaiz1/cmp_luasnip",
    commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843",
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
    commit = "44585a0c0085765195e6961c15529ba6c5a2a13b",
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
    commit = "040138616bec342d5ea94d4db296f8ddca17007a",
    priority = 1000,
  },
  {
    "L3MON4D3/LuaSnip",
    commit = "563827f00bb4fe43269e3be653deabc0005f1302",
  },
  {
    "williamboman/mason.nvim",
    commit = "e2f7f9044ec30067bc11800a9e266664b88cda22",
    config = function(_)
      require("plugins.mason-nvim")
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    commit = "8b9363d83b5d779813cdd2819b8308651cec2a09",
    config = function(_)
      require("plugins.mason-nvim-dap")
    end,
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    commit = "2daa8921b7afdcfa47419a21ea343c3df6d74fa0",
    config = function(_)
      require("plugins.mason-nvim-lspconfig")
    end,
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "folke/neodev.nvim",
    commit = "da1562e1e3df0e994ddc52cb4ba22376a5d7f2fc",
    config = function(_)
      require("plugins.neodev")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    commit = "a117163db44c256d53c3be8717f3e1a2a28e6299",
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
    commit = "0fd6519d44eac3a6736aafdb3fe9da916c3701d4",
    config = function(_)
      require("plugins.nvim-autopairs")
    end,
  },
  {
    "sindrets/diffview.nvim",
    commit = "d38c1b5266850f77f75e006bcc26213684e1e141",
  },
  {
    "hrsh7th/nvim-cmp",
    commit = "1e1900b0769324a9675ef85b38f99cca29e203b3",
  },
  {
    "hrsh7th/cmp-buffer",
    commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
  },
  {
    "hrsh7th/cmp-path",
    commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
  },
  {
    "hrsh7th/cmp-cmdline",
    commit = "8ee981b4a91f536f52add291594e89fb6645e451",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    commit = "44b16d11215dce86f253ce0c30949813c0a90765",
  },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    commit = "3d8912ebeb56e5ae08ef0906e3a54de1c66b92f1",
  },
  {
    "mfussenegger/nvim-dap",
    commit = "9d81c11fd185a131f81841e64941859305f6c42d",
    config = function(_)
      require("plugins.dap")
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    commit = "f5b6f3a90aae0284b61fb3565e575267c19a16e6",
    ft = "python",
  },
  {
    "rcarriga/nvim-dap-ui",
    commit = "0b4816e5ad5f3219e8e3ec9cce07f61b770c1974",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function(_)
      require("plugins.nvim-dap-ui")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    commit = "0b8165cf95806bc4bb8f745bb0c92021b2ed4b98",
    config = function(_)
      require("plugins.lspconfig")
    end,
    dependencies = { "williamboman/mason-lspconfig.nvim" },
  },
  {
    "SmiteshP/nvim-navic",
    commit = "8649f694d3e76ee10c19255dece6411c29206a54",
    config = function(_)
      require("plugins.nvim-navic")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    commit = "d1410cb0896a3aad5d84ddc54284774a627c6d63",
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
    commit = "01e43512ef8d137f2b9e5c1c74fd35c37e787b59",
    config = function(_)
      require("plugins.persistent-breakpoints")
    end,
  },
  {
    "luochen1990/rainbow",
    commit = "54c79a24725af3a15d3aad20f70a56c7abbd46c3",
  },
  {
    "nvim-telescope/telescope.nvim",
    commit = "d829aa64059001ee7b2c8c8aa9c4e6df0b17d893",
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
    commit = "1b9df577262b2c4c4ea422161742927f80ffa131",
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
    commit = "193786e0371e3286d3bc9aa0079da1cd41beaa62",
    config = function(_)
      require("plugins.toggleterm-nvim")
    end,
  },
  {
    "folke/trouble.nvim",
    commit = "897542f90050c3230856bc6e45de58b94c700bbf",
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
    commit = "c5afbe91d29c5e3be81d5125ddcdc276fd1f1322",
    config = function(_)
      require("plugins.vim-better-whitespace")
    end,
  },
  {
    "alvan/vim-closetag",
    commit = "c0779ef575d5c239162f4ca3506cfb4a95d45a58",
  },
  {
    "tpope/vim-commentary",
    commit = "627308e30639be3e2d5402808ce18690557e8292",
  },
  {
    "easymotion/vim-easymotion",
    commit = "d75d9591e415652b25d9e0a3669355550325263d",
  },
  {
    "tpope/vim-fugitive",
    commit = "5a24c2527584e4e61a706ad7ecb3514ac7031307",
  },
  {
    "farmergreg/vim-lastplace",
    commit = "48ba343c8c1ca3039224727096aae214f51327d1",
  },
  {
    "kburdett/vim-nuuid",
    commit = "6ae845f9348921f4e436c587da6d2bbf5691c4ed",
  },
  {
    "kshenoy/vim-signature",
    commit = "6bc3dd1294a22e897f0dcf8dd72b85f350e306bc",
  },
  {
    "dstein64/vim-startuptime",
    commit = "5f52ed26e0296a3e1d1453935f417e5808eefab8",
    lazy = true,
    cmd = { "StartupTime" },
  },
  {
    "tpope/vim-surround",
    commit = "f51a26d3710629d031806305b6c8727189cd1935",
  },

  -- Filetype-specific plugins.
  {
    "terrastruct/d2-vim",
    commit = "981c87dccb63df2887cc41b96e84bf550f736c57",
    ft = "d2",
  },
  {
    "liuchengxu/graphviz.vim",
    commit = "704aa42852f200db2594382bdf847a92fdab61fc",
    ft = "dot",
  },
  {
    "udalov/kotlin-vim",
    commit = "1261f851e5fb2192b3a5e1691650597c71dfce2f",
    ft = "kotlin",
  },
  {
    "jvirtanen/vim-hcl",
    commit = "1e1116c17a5774851360ea8077f349e36fc733c1",
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
    commit = "0aef250460683a78be7f947b68f5b0180bb47aab",
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
    commit = "717bd87ef928293e0cc6cfc12ebf2e007cb25311",
    ft = "toml",
  },
  {
    "broadinstitute/vim-wdl",
    commit = "1aaf200284b85d6075901faa8bda9ea67c6ce515",
    ft = "wdl",
  },
}

require("lazy").setup(specs)
