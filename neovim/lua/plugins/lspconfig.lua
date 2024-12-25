local api = vim.api
local augroup = api.nvim_create_augroup
local aucl = api.nvim_clear_autocmds
local au = api.nvim_create_autocmd

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-e>", function(_)
  return vim.diagnostic.open_float(nil, {
    focusable = false,
    scope = "cursor",
    -- close_events = {"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave"}
  })
end, opts)
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<A-q>", vim.diagnostic.setloclist, opts)

-- Diagnostic text.
vim.diagnostic.config {
  virtual_text = {
    spacing = 1,
    prefix = "⮜",
    format = function(_)
      return ""
    end,
  },
  signs = true,
  underline = true,
  severity_sort = true,
  float = {
    border = "single",
    format = function(diagnostic)
      local code = "?"
      if diagnostic.code then
        code = string.format("%s", diagnostic.code)
      elseif diagnostic.user_data ~= nil then
        code = string.format("%s", diagnostic.user_data.lsp.code)
      end
      return string.format("%s (%s) [%s]", diagnostic.message, diagnostic.source, code)
    end,
  },
}

-- Diagnostic gutter sign.
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for sev, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. sev
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local navic = require("nvim-navic")
navic.setup {
  highlight = true,
  separator = " ⟩ ",
  depth_limit = 0,
  depth_limit_indicator = "…",
  safe_output = true,
}

local on_init = function(client, initialization_result)
  if client.server_capabilities then
    client.server_capabilities.semanticTokensProvider = false
  end
end

local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gR", vim.lsp.buf.references, bufopts)

  vim.keymap.set("n", "<A-=>", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "=", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)

  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<S-f><S-f>", function()
    vim.lsp.buf.format { async = true }
  end, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)

  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  -- Common words highlight.
  if client.server_capabilities.documentHighlightProvider then
    local grp_lsphl = augroup("LSPDocumentHighlight", { clear = true })
    aucl { buffer = bufnr, group = grp_lsphl }
    au("CursorHold", { callback = vim.lsp.buf.document_highlight, buffer = bufnr, group = grp_lsphl })
    au("CursorMoved", { callback = vim.lsp.buf.clear_references, buffer = bufnr, group = grp_lsphl })
  end

  -- Winbar crumbs.
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
    vim.o.winbar = "%{%v:lua.require(\"nvim-navic\").get_location()%}"
  end
end

local lsp_flags = { debounce_text_changes = 150 }
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local none_ls = require("null-ls") -- not a typo, none-ls is a drop-in replacement for null-ls.
none_ls.setup {
  sources = {
    -- Go
    none_ls.builtins.formatting.goimports,
    none_ls.builtins.formatting.gofmt,
    -- Python
    none_ls.builtins.formatting.black,
    -- Lua
    none_ls.builtins.formatting.stylua.with {
      extra_args = {
        "--indent-type",
        "Spaces",
        "--indent-width",
        "2",
        "--call-parentheses",
        "Input",
        "--quote-style",
        "ForceDouble",
      },
    },
    -- Terraform
    none_ls.builtins.formatting.terraform_fmt.with {
      filetypes = { "terraform", "tf", "hcl" },
    },
    -- Nix
    none_ls.builtins.formatting.nixfmt,
    none_ls.builtins.code_actions.statix,
    none_ls.builtins.diagnostics.deadnix,
  },

  capabilities = capabilities,
  flags = lsp_flags,

  on_init = on_init,

  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- Autoformat on save using none-ls.
    if client.supports_method("textDocument/formatting") then
      local grp_lspfmt = augroup("LspFormatting", { clear = true })
      aucl { buffer = bufnr, group = grp_lspfmt }
      au("BufWritePre", {
        callback = function()
          vim.lsp.buf.format {
            bufnr = bufnr,
            filter = function(cl)
              return cl.name == "none-ls"
            end,
          }
        end,
        buffer = bufnr,
        group = grp_lspfmt,
      })
    end
  end,
}

require("mason-lspconfig").setup {
  automatic_installation = true,
}
local lspconfig = require("lspconfig")

local function opt_lspconfig(args)
  local ls = lspconfig[args.name]
  if ls == nil then
    return nil
  end
  return ls.setup(args.opts)
end

opt_lspconfig {
  name = "ansiblels",
  opts = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  },
}

opt_lspconfig {
  name = "bashls",
  opts = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  },
}

opt_lspconfig {
  name = "ccls",
  opts = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    init_options = {
      cache = {
        directory = "/tmp/ccls",
      },
    },
  },
}

opt_lspconfig {
  name = "gopls",
  opts = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
      gopls = {
        env = {
          GOFLAGS = "-tags=test",
        },
      },
    },
  },
}

opt_lspconfig {
  name = "nil_ls",
  opts = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  },
}

opt_lspconfig {
  name = "rust_analyzer",
  opts = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          features = "all",
          buildScripts = {
            enable = true,
          },
        },
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
}

opt_lspconfig {
  name = "pylsp",
  opts = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
      pylsp = {
        configurationSources = { "flake8" },
        plugins = {
          autopep8 = {
            enabled = false,
          },
          flake8 = {
            enabled = true,
          },
          mccabe = {
            enabled = false,
          },
          pyflakes = {
            enabled = false,
          },
          pylint = {
            enabled = false,
          },
          pycodestyle = {
            enabled = false,
          },
          pylsp_mypy = {
            enabled = true,
            dmypy = true,
            report_progress = true,
            live_mode = true,
          },
          yapf = {
            enabled = false,
          },
        },
      },
    },
  },
}

opt_lspconfig {
  name = "lua_ls",
  opts = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

opt_lspconfig {
  name = "jdtls",
  opts = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  },
}

local luasnip = require("luasnip")
local cmp = require("cmp")

local autopairs_loaded, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not autopairs_loaded then
  cmp_autopairs = nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-\\>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<C-J>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-K>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
}

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
  }),
})
if cmp_autopairs ~= nil then
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
