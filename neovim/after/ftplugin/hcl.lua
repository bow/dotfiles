local bufopt = vim.bo

bufopt.commentstring = '# %s'

bufopt.shiftwidth = 2
bufopt.tabstop = 2

bufopt.cindent = true
bufopt.cinoptions = bufopt.cinoptions .. ',(s,m1,+0'
