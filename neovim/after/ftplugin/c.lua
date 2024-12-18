local bufopt = vim.bo

bufopt.expandtab = true
bufopt.shiftwidth = 4
bufopt.tabstop = 4
bufopt.textwidth = require("constants").tw.half_screen
bufopt.commentstring = "// %s"
