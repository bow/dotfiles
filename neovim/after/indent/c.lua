local bufopt = vim.bo

bufopt.cindent = true
bufopt.cinoptions = bufopt.cinoptions .. ',(s,m1,l1,=s'
