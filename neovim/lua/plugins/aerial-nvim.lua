require('aerial').setup {
  on_attach = function(bufnr)
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
  layout = {
    resize_to_content = false,
  },
  filter_kind = false,
  autojump = true,
}
vim.keymap.set("n", "<C-c>", "<cmd>AerialToggle!<CR>")
