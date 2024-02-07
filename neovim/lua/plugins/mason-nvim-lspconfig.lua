require('mason-lspconfig').setup {
  ensure_installed = {
    'ansiblels',
    'gopls',
    'rust_analyzer',
    'pylsp',
    -- 'lua_ls',
    'jdtls',
  }
}
