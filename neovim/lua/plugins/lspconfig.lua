local api = vim.api
local augroup = api.nvim_create_augroup
local aucl = api.nvim_clear_autocmds
local au = api.nvim_create_autocmd

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<A-e>', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<A-q>', vim.diagnostic.setloclist, opts)

-- Diagnostic text.
vim.diagnostic.config {
  virtual_text = {
    spacing = 1,
    prefix = '⮜',
    format = function(_) return '' end,
  },
  signs = true,
  underline = true,
  severity_sort = true,
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

local navic = require('nvim-navic')
navic.setup {
  highlight = true,
  separator = ' ⟩ ',
  depth_limit = 0,
  depth_limit_indicator = '…',
  safe_output = true
}

local null_ls = require('null-ls')

null_ls.setup {
  sources = {
    -- Shell
    null_ls.builtins.diagnostics.shellcheck,
    -- Go
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.gofmt,
    -- Terraform
    null_ls.builtins.formatting.terraform_fmt.with {
      filetypes = {"terraform", "tf", "hcl"},
    },
  },

  on_attach = function(client, bufnr)
    -- Autoformat on save using null-ls.
    if client.supports_method("textDocument/formatting") then
      local grp_lspfmt = augroup("LspFormatting", { clear = true })
      aucl { buffer = bufnr, group = grp_lspfmt }
      au(
        "BufWritePre",
        {
          callback = function()
            vim.lsp.buf.format {
              bufnr = bufnr,
              filter = function(cl) return cl.name == "null-ls" end
            }
          end,
          buffer = bufnr,
          group = grp_lspfmt,
        }
      )
    end
  end
}

local on_attach = function(client, bufnr)

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gR', vim.lsp.buf.references, bufopts)

  vim.keymap.set('n', '<A-=>', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '=', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)

  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  -- Common words highlight.
  if client.server_capabilities.documentHighlightProvider then
    local grp_lsphl = augroup('LSPDocumentHighlight', {clear = true})
    aucl {buffer = bufnr, group = grp_lsphl}
    au(
      'CursorHold',
      {callback = vim.lsp.buf.document_highlight, buffer = bufnr, group = grp_lsphl}
    )
    au(
      'CursorMoved',
      {callback = vim.lsp.buf.clear_references, buffer = bufnr, group = grp_lsphl}
    )
  end

  -- Winbar crumbs.
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
    vim.o.winbar = '%{%v:lua.require("nvim-navic").get_location()%}'
  end
end

local lsp_flags = { debounce_text_changes = 150 }
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup {
  automatic_installation = true,
}
local lspconfig = require('lspconfig')

local function opt_lspconfig(args)
  local ls = lspconfig[args.name]
  if ls == nil then
    return nil
  end
  return ls.setup(args.opts)
end

opt_lspconfig {
  name = 'ansiblels',
  opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  },
}

opt_lspconfig {
  name = 'ccls',
  opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    init_options = {
      cache = {
        directory = '/tmp/ccls'
      },
    },
  },
}

opt_lspconfig {
  name = 'gopls',
  opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
      gopls = {
        env = {
          GOFLAGS = '-tags=test',
        },
      },
    },
  }
}

opt_lspconfig {
  name = 'rust_analyzer',
  opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  }
}

opt_lspconfig {
  name = 'pylsp',
  opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
      pylsp = {
        configurationSources = {'flake8'},
        plugins = {
          pylsp_mypy = {
            enabled = true,
            dmypy = true,
          },
        },
      },
    },
  }
}

opt_lspconfig {
  name = 'sumneko_lua',
  opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
}

local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
}

cmp.setup.cmdline(
  '/',
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  }
)
cmp.setup.cmdline(
  ':',
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        { name = 'path' }
      },
      {
        {name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } }
      }
    )
  }
)
