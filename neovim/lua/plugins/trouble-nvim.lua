require("trouble").setup {
  auto_jump = false,
  focus = true,
  open_no_results = false,
  modes = {
    preview_float = {
      mode = "diagnostics",
      preview = {
        type = "float",
        relative = "editor",
        border = "rounded",
        title = "Preview",
        title_pos = "center",
        position = { 0, -2 },
        size = { width = 0.3, height = 0.3 },
        zindex = 200,
      },
    },
  },
}

local u = require("utils")
u.nnoremap { "<A-e>", "<cmd>Trouble diagnostics toggle<CR>" }
u.nnoremap { "gr", "<cmd>Trouble lsp_references toggle<CR>" }
u.nnoremap { "gi", "<cmd>Trouble lsp_implementations toggle<CR>" }
