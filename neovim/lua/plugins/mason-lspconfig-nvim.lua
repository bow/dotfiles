require('mason-lspconfig').setup {
  ensure_installed = {
    'pylsp',
    'gopls',
  },
  automatic_installation = true,
}
