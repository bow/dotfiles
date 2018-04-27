" .vimrc
" Wibowo Arindrarto <bow@bow.web.id>
""""""""""""""""""""""""""""""""""""

" Setup Pathogen.
call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()


" Set character encoding.
set encoding=utf-8

" Set global leader key.
let mapleader = ','

" Set command completion menu.
set wildmenu

" Set backup of existing file.
set backup

" Set pattern of filenames that are not backed up.
set backupskip=/tmp/*,/private/tmp/*

" Create backup before overwriting file.
set writebackup

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

" Enable file type-specific autoindenting..
filetype indent on

" Enable filetype specific plugins.
filetype plugin on

" Show entered command.
set showcmd

" Hide default vim mode.
set noshowmode

" Always show status line
set laststatus=2

" Always show one line below cursor
set scrolloff=1

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

" Set base colorscheme.
colorscheme jellybeans

" Set auto indentation.
set autoindent

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

" Filetype-specific settings
augroup FTS
    au!

    au FileType circos setlocal tw=80 ts=2 sw=2 formatoptions=tcroqn2 comments=n:>
    au BufNewFile,BufRead circos*.conf,ideogram*.conf,ticks*.conf setlocal ft=circos

    au FileType cython setlocal tw=80
    au BufNewFile,BufRead *.pyx setlocal ft=cython

    au FileType bed setlocal wrap linebreak noexpandtab
    au BufNewFile,BufRead *.bed setlocal ft=bed

    au FileType gtf setlocal wrap linebreak noexpandtab
    au BufNewFile,BufRead *.gtf setlocal ft=gtf

    au FileType gff setlocal wrap linebreak noexpandtab
    au BufNewFile,BufRead *.gff setlocal ft=gff

    au FileType javascript setlocal tw=80 ts=2 sw=2
    au BufNewFile,BufRead *.js,*.jsx setlocal ft=javascript

    au FileType make setlocal tw=100
    au BufNewFile,BufRead Makefile,*.mk setlocal ft=make

    au FileType markdown setlocal ts=2 sw=2
    au BufNewFile,BufRead *.md,*.MD setlocal ft=markdown

    au FileType plaintex setlocal ts=2 sw=2
    au BufNewFile,BufRead *.tex setlocal ft=plaintex

    au FileType refFlat setlocal wrap linebreak noexpandtab
    au BufNewFile,BufRead *.refFlat setlocal ft=refFlat

    au FileType rst setlocal ts=2 sw=2
    au BufNewFile,BufRead *.rst,*.RST setlocal ft=rst

    au FileType sam setlocal wrap linebreak noexpandtab
    au BufNewFile,BufRead *.sam setlocal ft=sam

    au FileType scala setlocal tw=120 ts=2 sw=2
    au BufNewFile,BufRead *.scala,*.sc setlocal ft=scala

    au FileType snakemake setlocal tw=100
    au BufNewFile,BufRead Snakefile,Snakefile.*,*.snakefile,*.snake,*.rule,*.rules setlocal ft=snakemake

    au FileType tsv setlocal wrap linebreak noexpandtab
    au BufNewFile,BufRead *.tsv setlocal ft=tsv

    au FileType yaml setlocal ts=2 sw=2 indentkeys-=<:>
    au BufNewFile,BufRead *.yml,*.yaml setlocal ft=yaml

    au FileType wdl setlocal tw=100 ts=2 sw=2
    au BufNewFile,BufRead *.wdl setlocal ft=wdl

    au FileType c setlocal tw=100
    au FileType cfg setlocal ts=2 sw=2
    au FileType css setlocal tw=100 ts=2 sw=2
    au Filetype gitcommit setlocal spell tw=72
    au FileType go setlocal tw=150 noexpandtab nolist
    au FileType html,htmljinja setlocal ts=2 sw=2
    au FileType mako setlocal ts=2 sw=2
    au FileType json setlocal ts=2 sw=2
    au FileType php setlocal tw=100 ts=2 sw=2
    au FileType ruby setlocal tw=80 ts=2 sw=2
    au FileType python setlocal tw=80
    au FileType R setlocal tw=100 ts=2 sw=2
    au FileType xml setlocal ts=2 sw=2
    au FileType xml,xhtml,htmljinja so ~/.vim/ftplugin/html_autoclosetag.vim

    au BufNewFile,BufRead *.cool,*.cl setlocal ft=cool
    au BufNewFile,BufRead *.cwl setlocal ft=yaml
    au BufNewFile,BufRead .envrc setlocal ft=bash
    au BufNewFile,BufRead *.jdl setlocal ft=jdl
    au BufNewFile,BufRead *.hs setlocal ft=haskell
    au BufNewFile,BufRead *.lgr setlocal ft=ledger
    au BufNewFile,BufRead *.lalrpop setlocal ft=rust
    au BufNewFile,BufRead Pipfile setlocal ft=toml
    au BufNewFile,BufRead Pipfile.lock setlocal ft=json
    au BufNewFile,BufRead *.rl setlocal ft=ragel
    au BufNewFile,BufRead Vagrantfile setlocal ft=ruby
augroup END


" Setup vim-airline.
let g:airline_theme='term'
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch="⎇ "
let g:airline_powerline_fonts=1
set guifont=Inconsolata\ for\ Powerline

" Custom airline function to add total line number
function! AirlineInit()
    let spc = g:airline_symbols.space
    let g:airline_section_z = airline#section#create(['%3p%%'.spc, 'linenr', '/%L', ':%3c '])
endfunction
au VimEnter * call AirlineInit()

" Highlight workds not recognized by spellcheker.
hi SpellBad term=reverse ctermbg=5

" Highlight matching parentheses.
hi MatchParen gui=bold guibg=NONE guifg=lightblue cterm=bold ctermbg=NONE

" Disable background highlighting on non-texts.
hi NonText guibg=NONE ctermbg=NONE

" Disable background highlighting on normal text.
hi Normal guibg=NONE ctermbg=NONE


" Show current line number.
set number

" Show line numbers relative to current line number.
set relativenumber

" Toggle relative numbering on buffer enter and leave events.
au BufEnter * :set relativenumber
au BufLeave * :set norelativenumber


" Setup rainbow parens.
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" Setup indent guides.
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'go']


" Setup Syntastic.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ignore_files = ['.*\.sbt$', '*\.lalrpop$']

let g:syntastic_scala_checkers = []
let g:syntastic_java_checkers = []

let g:syntastic_python_checkers = ['flake8']

let g:syntastic_rust_rustc_exe = 'cargo check'
let g:syntastic_rust_rustc_fname = ''
let g:syntastic_rust_rustc_args = '--'
let g:syntastic_rust_checkers = []

let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
let g:syntastic_cpp_include_dirs = ["/home/bow/local/lib"]

let g:syntastic_html_tidy_ignore_errors = [
    \ '<html> attribute "lang" lacks value',
    \ '<a> attribute "href" lacks value',
    \ '<a> proprietary attribute "alt"',
    \ 'trimming empty <span>',
    \ 'trimming empty <i>'
    \ ]

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif


" Disable vim-r-plugin integration with screen.vim
let vimrplugin_screenplugin = 0

" Disable '_' auto replacement with '<-' in R files.
let g:vimrplugin_underscore = 0

" List of VCS that vim-signify uses.
let g:signify_vcs_list = [ 'git' ]

" List of excluded name patterns in editorconfig-vim.
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


" Setup NERDTree.
let g:NERDTreeWinSize = 31                          "adjust window size
let NERDTreeMapPreview = 'n'                        "remap preview key
let NERDTreeIgnore=['\.pyc$', '\.swp$', '\~$']      "file types to ignore


" Setup CtrlP.
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|class|jar|tar.gz|tgz|swp|swo|pyc|pyo)$',
    \ }


" Setup Tagbar.
let g:tagbar_width = 60
let g:tagbar_show_linenumbers = 1
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }


" Remaps - buffer navigation.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remap toggle for search highlighting.
nnoremap <silent> ,/ :set hlsearch!<CR>

" Remap shortcut for entering commands.
nnoremap ; :

" Remap shortcut for toggling relative numbers.
nnoremap <C-n> :set relativenumber!<CR>

" Remaps - plugin shortcuts.
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> :TagbarToggle<CR>

" Remaps - shortcuts for dropdown popups.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Remaps - command mode.
cnoremap w!! w !sudo tee % >/dev/null
