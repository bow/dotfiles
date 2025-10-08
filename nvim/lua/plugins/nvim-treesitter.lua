return {
  'nvim-treesitter/nvim-treesitter',
  build = function(_)
    if not require('utils').in_nixos() then
      vim.cmd(':TSUpdate')
    end
  end,
  main = 'nvim-treesitter.configs',
  opts = function(_, opts)
    local ensure_installed = {}
    if not require('utils').in_nixos() then
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
      }
    end
    return {
      ensure_installed = ensure_installed,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = false },
    }
  end,
  init = function()
    vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>Inspect<cr>', { unique = true })
  end,
}
