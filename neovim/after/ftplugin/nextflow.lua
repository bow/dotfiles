local bufopt = vim.bo

bufopt.commentstring = "// %s"
bufopt.shiftwidth = 4
bufopt.tabstop = 4
bufopt.textwidth = require("constants").tw.half_screen
