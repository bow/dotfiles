DOTFILES
========

Settings and configurations for a command line environment that feels like home.


### Vim plugins

This repository uses `git subtree` to manage vim plugin subrepositories.
The command to set them up are the following:

```
# ctrlp.vim
git remote add -f vimplugin_ctrlp.vim https://github.com/kien/ctrlp.vim.git
git subtree add -P vim/.vim/bundle/ctrlp.vim --squash -m "Add ctrlp.vim plugin" vimplugin_ctrlp.vim master
# the same for tagbar, vim-surround
```
