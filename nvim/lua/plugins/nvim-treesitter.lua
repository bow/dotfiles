return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = function(_)
    if not require('utils').in_nixos() then
      vim.cmd(':TSUpdate')
    end
  end,
  main = 'nvim-treesitter',
  opts = function(_, opts)
    return {
      sync_install = false,
    }
  end,
  init = function()
    if not require('utils').in_nixos() then
      local ensure_installed = {
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
      local already_installed = require('nvim-treesitter.config').get_installed()
      local to_install = vim
          .iter(ensure_installed)
          :filter(function(parser)
            return not vim.tbl_contains(already_installed, parser)
          end)
          :totable()
      require('nvim-treesitter').install(to_install)
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>Inspect<cr>', { unique = true })
  end,
}
