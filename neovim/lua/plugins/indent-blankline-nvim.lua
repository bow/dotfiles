require("ibl").setup {
  enabled = true,
  indent = {
    char = "│",
  },
  scope = {
    enabled = true,
    show_end = false,
    show_exact_scope = true,
    show_start = false,
    highlight = { "Function", "Label" },
    include = {
      node_type = { ["*"] = { "*" } },
    },
  },
}
