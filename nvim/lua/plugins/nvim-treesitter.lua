return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function(_, opts)
    local u = require('utils')

    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'csv',
        'diff',
        'elixir',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'haskell',
        'html',
        'http',
        'ini',
        'java',
        'javascript',
        'jq',
        'json',
        'just',
        'latex',
        'lua',
        'nix',
        'proto',
        'python',
        'rust',
        'terraform',
        'toml',
        'tsv',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = false },
    }

    u.nnoremap { '<leader>t', '<cmd>Inspect<cr>' }
  end,
}
