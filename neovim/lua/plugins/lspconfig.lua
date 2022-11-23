
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<A-d>', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<A-q>', vim.diagnostic.setloclist, opts)

-- Diagnostic text.
vim.diagnostic.config {
  virtual_text = {
    spacing = 0,
    prefix = '◆',
    format = function(diagnostic) return '' end,
  },
  signs = true,
  underline = false,
  float = {
    border = 'single',
    format = function(diagnostic)
      return string.format(
        '%s (%s) [%s]',
        diagnostic.message,
        diagnostic.source,
        diagnostic.code or diagnostic.user_data.lsp.code
      )
    end,
  },
}

-- Diagnostic gutter sign.
local signs = {Error = '', Warn = '', Hint = '', Info = ''}
for sev, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. sev
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<A-=>', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

require('lspconfig')['pylsp'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    pylsp = {
      configurationSources = {'flake8'},
    }
  },
}
