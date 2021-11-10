" nvim/init.vim
" Wibowo Arindrarto <contact@arindrarto.dev>

lua << EOF
local g = vim.g
g.python3_host_prog = '/usr/bin/python3'
g.mapleader = ','
EOF

" Load plugins
lua require 'plugins'

" Set global settings
lua require 'settings'

" Set base colorscheme and its related options.
lua <<EOF
local g = vim.g
local opt = vim.o

opt.termguicolors = true

g.gruvbox_italic = 1
g.gruvbox_italic = 1
g.gruvbox_italicize_strings = 0
g.gruvbox_italicize_comments = 1
g.gruvbox_invert_selection = 0
g.gruvbox_contrast_dark = 'hard'
vim.cmd [[colorscheme gruvbox]]

opt.background = 'dark'
EOF


" Remove Esc delay when exiting from insert mode.
augroup FastEscape
    au!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=500
augroup END


" Setup vim-airline.
let g:airline#skip_empty_sections = 1
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_symbols.branch = "⎇ "
let g:airline_symbols.notexists = "*"

" Set airline font.
set guifont=Inconsolata\ for\ Powerline
" This highlight group is used for the airline warning.
hi SpellRare guifg=#111111 guibg=#b57614

" Custom airline function to add total line number
function! AirlineInit()
    let spc = g:airline_symbols.space
    let g:airline_section_z = airline#section#create(['%3p%%'.spc, 'linenr', '/%L', ':%3c '])
endfunction
au VimEnter * call AirlineInit()

" Highlight words not recognized by spellcheker.
hi SpellBad term=reverse cterm=NONE

" Highlighting scheme for search results.
hi Search cterm=NONE ctermbg=darkgreen ctermfg=black

" Highlight matching parentheses.
hi MatchParen gui=bold guibg=NONE guifg=lightblue cterm=bold ctermbg=NONE

" Disable background highlighting on non-texts.
hi NonText guifg=grey23 guibg=NONE ctermfg=white ctermbg=NONE

" Set text width column color.
hi ColorColumn guibg=#262626

" Set gutter color.
hi SignColumn guibg=#262626

" Set gutter line indicator color.
hi CursorLineNr guibg=#262626

" Set vertical split color.
hi VertSplit guibg=#262626

" Set visual selection color.
hi Visual guibg=grey23


" Toggle relative numbering on buffer enter and leave events.
augroup NumberToggle
  au!
  au BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | setl rnu   | endif
  au BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | setl nornu | endif
augroup END


" Setup rainbow parens.
let g:rainbow_active = 1


" Setup indent guides.
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help']
let g:indent_guides_guide_size = 4
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
au VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#1d2021 ctermbg=NONE
au VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#262626 ctermbg=234

" Disable vim-r-plugin integration with screen.vim
let vimrplugin_screenplugin = 0
let g:vimrplugin_term = "alacritty"

" Disable '_' auto replacement with '<-' in R files.
let g:vimrplugin_underscore = 0

" Setup vim-signify.
let g:signify_vcs_list = [ 'git' ]
hi SignifySignAdd    gui=bold guifg=#262626 guibg=#427b58
hi SignifySignDelete gui=bold guifg=#262626 guibg=#af3a03
hi SignifySignChange gui=bold guifg=#262626 guibg=#b57614
let g:signify_sign_delete = '-'

" Setup CtrlP.
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](
        \\.git|\.hg|\.svn
        \|__pycache__|node_modules|bower_components
        \|build|wheels|target|_deps|dist|coverage|htmlcov
        \|_build
        \|.snakemake
        \|.DS_Store
        \)$|.egg-info$',
    \ 'file': '\v\.(
        \exe|so|dll|pdf|dvi|png|jpg|jpeg|ico
        \|doc|docx|xls|xlsx|xlsm
        \|bcl|cbcl|fastq|fasta|sam|bam|cram|vcf|bcf|gff|gtf|bed|wig|bigwig
        \|sif|simg
        \|mp4|mkv|avi|mpg
        \|mp3|flac
        \|swp|swo|whl
        \|pyc|pyo|jar|class
        \|tgz|tar|zip|gz|gzip|bz2|xz
        \)$',
    \ }


" Remaps - buffer navigation.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-Right> :bn<CR>
nnoremap <C-Left> :bp<CR>

" Remap toggle for search highlighting.
nnoremap <silent> ,/ :set hlsearch!<CR>

" Remap shortcut for entering commands.
nnoremap ; :

" Remap shortcut for toggling relative numbers.
nnoremap <C-n> :set relativenumber!<CR>

" Remap for sourcing config.
nnoremap <leader>sv :source $MYVIMRC<CR>

" Remaps - shortcuts for dropdown popups.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Remaps - command mode.
cnoremap w!! w !sudo tee % >/dev/null

" Settings for coc.nvim ~ adapted from their wiki.
let g:coc_global_extensions = [
\   'coc-eslint',
\   'coc-css',
\   'coc-go',
\   'coc-html',
\   'coc-java',
\   'coc-json',
\   'coc-prettier',
\   'coc-pyright',
\   'coc-rls',
\]

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Configure nvim-tree.lua
nnoremap <C-e> :NvimTreeToggle<CR>

lua << EOF
local g = vim.g

g.nvim_tree_gitignore = 1
g.nvim_tree_add_trailing = 1
g.nvim_tree_group_empty = 1
g.nvim_tree_special_files = {}

local fns = {'Makefile', 'README.adoc', 'README.md', 'README.rst'}

for _, fn in ipairs(fns) do
    g.nvim_tree_special_files[fn] = 1
end

require'nvim-tree'.setup {
  view = {
    width = '20%'
  },
}
EOF

" Configure Telescope key maps.
nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope live_grep<cr>
nnoremap <C-s> <cmd>Telescope grep_string<cr>
nnoremap <C-b> <cmd>Telescope buffers<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation in preview window.
nnoremap <silent> <A-=> :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Highlight the symbol and its references when holding the cursor.
au CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup MyGroup
  au!
  " Setup formatexpr specified filetype(s).
  au FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <C-d>  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Set more custom colors
hi Error guifg=#1d2021 guibg=#cc241d gui=bold
hi NvimInternalError guifg=#1d2021 guibg=#cc241d gui=bold
" Coc colors"
hi CocHintHighlight guifg=#1d2021 guibg=#98971a gui=bold
hi CocInfoHighlight guifg=#1d2021 guibg=#458588 gui=bold
hi CocInfoSign guifg=#458588 guibg=#262626 gui=none
hi CocWarningHighlight guifg=#1d2021 guibg=#d79921 gui=bold
hi CocWarningSign guifg=#d79921 guibg=#262626 gui=none
hi CocErrorHighlight guifg=#1d2021 guibg=#cc241d gui=bold
hi CocErrorSign guifg=#cc241d guibg=#262626 gui=none
