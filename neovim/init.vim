" nvim/init.vim
" Wibowo Arindrarto <contact@arindrarto.dev>

let g:python3_host_prog = '/usr/bin/python3'

" Load plugins
lua require("plugins")

" Enable local .vimrc use.
set exrc

" Restrict some command in non-default .vimrc.
set secure

" Set character encoding.
set encoding=utf-8

" Set global leader key.
let mapleader = ','

" Enable mouse in all modes.
set mouse+=a

" Set command completion menu.
set wildmenu

" Set backup directories.
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Set directories for swap file.
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Disable search highlighting.
set nohlsearch

" Show match as search proceeds.
set incsearch

" Set search to be case insensitive
set ignorecase

" Set search to be case sensitive when caps are used.
set smartcase

" Set :split to create a new window below current one.
set splitbelow

" Set :vsplit to create a new window right of the current one.
set splitright

" Use buffer for unwritten changes.
set hidden

" Allow backspacing over autoindent, line breaks, and start of insert.
set backspace=indent,eol,start

" Set paste mode toggle key.
set pastetoggle=<F5>

" Enable syntax highlighting.
syntax on

" Detect file extension.
filetype on

" Enable file type-specific autoindenting.
filetype indent on

" Enable filetype specific plugins.
filetype plugin on

" Show entered command.
set showcmd

" Show the sign column.
set signcolumn=yes

" Hide default vim mode.
set noshowmode

" Set command bar height.
set cmdheight=1

" Always show status line
set laststatus=2

" Always show one line below cursor
set scrolloff=1

" Disable GUI cursor
set guicursor=

" Highlight column after 'textwidth' / 'tw'.
set colorcolumn=+1

" Show whitespace characters.
set list

" Map whitespaces to visible characters.
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Set cindent.
set cindent

" Set color to 256 colors.
set t_Co=256

" Set GUI colors.
set termguicolors

" Set base colorscheme and its related options.
let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 0
let g:gruvbox_italicize_comments = 1
let g:gruvbox_invert_selection = 0
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

" Ensure background is dark.
set background=dark

" Set auto indentation.
set autoindent

" Set smart indentation.
set smartindent

" Replace tabs with spaces.
set expandtab

" Set number of spaces for tab replacement.
set tabstop=4

" Set indentation width.
set shiftwidth=4

" Use multiples of shiftwidth.
set shiftround

" Set unlimited maximum line length.
set textwidth=0

" Disable line wrapping.
set nowrap

" Set indent-based folding
set foldmethod=indent

" Set deepest allowed fold level.
set foldnestmax=10

" Open all folds by default.
set nofoldenable

" Add paths for file lookup.
let &path.="src/include,/usr/include/AL,"

" Decrease updatetime.
set updatetime=100

" Shorten command timeout length (default: 1000).
set timeoutlen=500

" Remove Esc delay when exiting from insert mode.
augroup FastEscape
    au!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=500
augroup END

" Filetype-specific settings
augroup FTS
    au!

    au FileType asciidoc setl ts=2 sw=2 tw=90 wrap commentstring=//\ %s
    au BufNewFile,BufRead *.adoc,*.asciidoc setl ft=asciidoc

    au FileType circos setl tw=80 ts=2 sw=2 formatoptions=tcroqn2 comments=n:>
    au BufNewFile,BufRead circos*.conf,ideogram*.conf,ticks*.conf setl ft=circos

    au FileType cython setl tw=80
    au BufNewFile,BufRead *.pyx setl ft=cython

    au FileType bed setl wrap linebreak noexpandtab
    au BufNewFile,BufRead *.bed setl ft=bed

    au FileType gtf setl wrap linebreak noexpandtab
    au BufNewFile,BufRead *.gtf setl ft=gtf

    au FileType gff setl wrap linebreak noexpandtab
    au BufNewFile,BufRead *.gff setl ft=gff

    au FileType go setl tw=100 noexpandtab nolist
    au BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

    au FileType java setl tw=120
    au BufWritePre *.java :silent call CocAction('runCommand', 'editor.action.organizeImport')

    au FileType javascript setl tw=80 ts=2 sw=2
    au BufNewFile,BufRead *.js,*.jsx setl ft=javascript

    au FileType make setl tw=100
    au BufNewFile,BufRead,BufWritePost Makefile,*.mk,*.make setl ft=make

    au FileType markdown setl ts=2 sw=2 tw=90 wrap
    au BufNewFile,BufRead *.md,*.MD setl ft=markdown

    au FileType plaintex setl ts=2 sw=2 tw=100 wrap
    au BufNewFile,BufRead *.tex setl ft=plaintex

    au FileType refFlat setl wrap linebreak noexpandtab
    au BufNewFile,BufRead *.refFlat setl ft=refFlat

    au FileType rst setl ts=2 sw=2 tw=90 wrap
    au BufNewFile,BufRead *.rst,*.RST setl ft=rst

    au FileType sam setl wrap linebreak noexpandtab
    au BufNewFile,BufRead *.sam setl ft=sam

    au FileType scala setl tw=120 ts=2 sw=2
    au BufNewFile,BufRead *.scala,*.sc setl ft=scala

    au FileType snakemake setl tw=100
    au BufNewFile,BufRead Snakefile,Snakefile.*,*.snakefile,*.snake,*.rule,*.rules setl ft=snakemake

    au FileType text setl wrap

    au FileType typescript setl tw=100 ts=4 sw=4
    au BufNewFile,BufRead *.ts setl ft=typescript

    au FileType tsv setl wrap linebreak noexpandtab
    au BufNewFile,BufRead *.tsv setl ft=tsv

    au FileType yaml setl ts=2 sw=2 indentkeys-=<:>
    au BufNewFile,BufRead *.yml,*.yaml setl ft=yaml

    au FileType wdl setl tw=100 ts=2 sw=2 nocindent
    au BufNewFile,BufRead *.wdl setl ft=wdl

    au FileType bib setl ts=2 sw=2 tw=100
    au FileType c setl tw=100
    au FileType cfg setl ts=2 sw=2
    au FileType cpp setl tw=100
    au FileType css setl tw=100 ts=2 sw=2
    au FileType dockerfile setl tw=100
    au FileType scss setl tw=100 ts=2 sw=2
    au FileType elixir setl tw=100
    au FileType erlang setl tw=100 ts=2 sw=2
    au Filetype gitcommit setl spell tw=72
    au FileType hocon setl ts=2 sw=2
    au FileType html,htmljinja,jinja setl ts=2 sw=2
    au FileType lua setl ts=2 sw=2
    au FileType mako setl ts=2 sw=2
    au FileType json setl ts=2 sw=2
    au FileType php setl tw=100 ts=2 sw=2
    au FileType proto setl tw=100
    au FileType python setl indentkeys-=<:> indentkeys-=: tw=88
    au FileType ruby setl tw=80 ts=2 sw=2
    au FileType rust setl tw=99 ts=4 sw=4
    au FileType sql setl commentstring=--\ %s
    au FileType R setl tw=100 ts=2 sw=2
    au FileType tex setl ts=2 sw=2 tw=100 wrap
    au FileType xml setl ts=2 sw=2
    au FileType xml,xhtml,htmljinja so ~/.vim/ftplugin/html_autoclosetag.vim

    au BufNewFile,BufRead *.cool,*.cl setl ft=cool
    au BufNewFile,BufRead *.cwl setl ft=yaml
    au BufNewFile,BufRead .envrc setl ft=bash
    au BufNewFile,BufRead *.jdl setl ft=jdl
    au BufNewFile,BufRead *.jsonl setl ft=json
    au BufNewFile,BufRead *.hs setl ft=haskell
    au BufNewFile,BufRead *.lgr setl ft=ledger
    au BufNewFile,BufRead *.mdj setl ft=json
    au BufNewFile,BufRead *.lalrpop setl ft=rust
    au BufNewFile,BufRead Pipfile setl ft=toml
    au BufNewFile,BufRead Pipfile.lock setl ft=json
    au BufNewFile,BufRead Tiltfile,Tiltfile.* setl ft=bzl
    au BufNewFile,BufRead *.rl setl ft=ragel
    au BufNewFile,BufRead Vagrantfile setl ft=ruby

    au BufNewFile,BufRead roles/*/*.yml,playbooks/*.yml set ft=yaml.ansible
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
hi NonText guifg=bg guibg=NONE ctermfg=bg ctermbg=NONE

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

" Show current line number.
set number

" Show line numbers relative to current line number.
set relativenumber

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

" Set default SQL file types to PostgreSQL
let g:sql_type_default = 'pgsql'

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

" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Configure nvim-tree.lua
nnoremap <C-e> :NvimTreeToggle<CR>
let g:nvim_tree_gitignore = 1
let g:nvim_tree_add_trailing = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_special_files = {
\   'Makefile': 1,
\   'README.adoc': 1,
\   'README.md': 1,
\   'README.rst': 1
\}

lua << EOF
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

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
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

command! Scratch lua require'tools'.makeScratch()
