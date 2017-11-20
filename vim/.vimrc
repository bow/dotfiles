"Pathogen
call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
let vimrplugin_screenplugin = 0

"GO
set rtp+=$GOROOT/misc/vim

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'go']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_scala_checkers = []
let g:syntastic_java_checkers = []
let g:syntastic_ignore_files = ['.*\.sbt$', '*\.lalrpop$']

let g:syntastic_rust_rustc_exe = 'cargo check'
let g:syntastic_rust_rustc_fname = ''
let g:syntastic_rust_rustc_args = '--'
let g:syntastic_rust_checkers = ['rustc']

let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
let g:syntastic_cpp_include_dirs = ["/home/bow/local/lib"]

let g:syntastic_html_tidy_ignore_errors = [
    \ '<html> attribute "lang" lacks value',
    \ '<a> attribute "href" lacks value',
    \ '<a> proprietary attribute "alt"',
    \ 'trimming empty <span>',
    \ 'trimming empty <i>'
    \ ]

"DISPLAY
set noshowmode                  "hide default vim status
set laststatus=2                "always show statusline
set scrolloff=1                 "always show one line below cursor
set t_Co=256                    "set color to 256 colors
colorscheme jellybeans          "colorscheme
let g:airline_theme='term'      "vim-airline color scheme
let g:airline#extensions#tabline#enabled = 1
syntax on                       "turns on color syntax in various programming languages
filetype indent on              "enable autoindenting for specific filetypes
filetype plugin on              "enable filetype specific plugins
filetype on                     "detect file extension
set relativenumber              "show line number
set showcmd                     "show entered command
set colorcolumn=+1
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" airline display settings
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif
let g:airline_symbols.branch="⎇ "
let g:airline_powerline_fonts=1
set guifont=Inconsolata\ for\ Powerline
" custom airline function to add total line number
function! AirlineInit()
    let spc = g:airline_symbols.space
    let g:airline_section_z = airline#section#create(['%3p%%'.spc, 'linenr', '/%L', ':%3c '])
endfunction
autocmd VimEnter * call AirlineInit()

set wildmenu

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

let g:signify_vcs_list = [ 'git' ]

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"FILETYPE-SPECIFIC
augroup filetype
 au! BufNewFile,BufRead circos*conf,ideogram*conf,ticks*conf  set ft=circos ai tw=80 shiftwidth=2 tabstop=2 formatoptions=tcroqn2 comments=n:>
augroup END
au BufNewFile,BufRead *.lgr set syntax=ledger
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.rules set syntax=snakemake
au BufNewFile,BufRead *.snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake
au BufNewFile,BufRead *.skw set syntax=snakemake
au BufNewFile,BufRead *.skr set syntax=snakemake
au BufNewFile,BufRead *.lalrpop set syntax=rust
au BufRead,BufNewFile *.tsv setlocal tw=10000 noexpandtab
au BufRead,BufNewFile *.tex setlocal shiftwidth=2 tabstop=2
au BufRead,BufNewFile *.wdl setlocal tw=120 shiftwidth=2 tabstop=2
au BufRead,BufNewFile *.sam setlocal filetype=sam tw=10000 noexpandtab
au BufRead,BufNewFile *.bed setlocal filetype=bed tw=10000 noexpandtab
au BufRead,BufNewFile *.gtf setlocal filetype=gtf tw=10000 noexpandtab
au BufRead,BufNewFile *.gff setlocal filetype=gff tw=10000 noexpandtab
au BufRead,BufNewFile *.refFlat setlocal filetype=refFlat tw=10000 noexpandtab
au BufRead,BufNewFile *.scala setlocal filetype=scala tw=120
au BufRead,BufNewFile *.sc setlocal filetype=scala tw=120
au BufRead,BufNewFile *.hs setlocal filetype=haskell
au BufRead,BufNewFile *.rl setlocal filetype=ragel
au BufRead,BufNewFile *.mkc setlocal filetype=make tw=200
au BufRead,BufNewFile *.mkn setlocal filetype=make tw=200
au BufRead,BufNewFile *.mki setlocal filetype=make tw=200
au BufRead,BufNewFile *.jdl setlocal filetype=jdl tw=200
au BufRead,BufNewFile *.json setlocal tabstop=2 shiftwidth=2 tw=1000
au BufRead,BufNewFile *.js setlocal filetype=javascript tabstop=2 shiftwidth=2 tw=80
au BufRead,BufNewFile *.jsx setlocal filetype=javascript tabstop=2 shiftwidth=2 tw=80
au BufRead,BufNewFile *.rb setlocal filetype=ruby tabstop=2 shiftwidth=2
au BufRead,BufNewFile *.rst setlocal tw=120
au BufRead,BufNewFile *.cwl set syntax=yaml filetype=yaml
au BufRead,BufNewFile *.pyx set syntax=cython filetype=cython tw=80
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd FileType go setlocal noexpandtab tabstop=4 tw=150 nolist
autocmd FileType py setlocal tw=80
autocmd FileType python setlocal tw=80
autocmd FileType rst setlocal tw=80
autocmd FileType markdown  setlocal shiftwidth=2 tabstop=2
autocmd FileType md setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmljinja setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2
autocmd FileType php setlocal shiftwidth=2 tabstop=2
autocmd FileType mako setlocal shiftwidth=2 tabstop=2
autocmd FileType R setlocal shiftwidth=2 tabstop=2
autocmd FileType c setlocal shiftwidth=2 tabstop=2
autocmd FileType cfg setlocal shiftwidth=2 tabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 indentkeys-=<:>
autocmd FileType scala setlocal shiftwidth=2 tabstop=2
autocmd FileType xhtml, xml, htmljinja so ~/.vim/ftplugin/html_autoclosetag.vim
let g:vimrplugin_underscore = 0
let mapleader = ','

"SPACES & INDENTS
set autoindent                  "turns on autoindent
set expandtab                   "use spaces instead of actual tabs
set shiftwidth=4                "indenting is 4 spaces
set shiftround                  "use multiples of shiftwidth
set cindent                     "turns on cindent
set tabstop=4                   "tabs are replaced by 4 spaces
set list                        "show unprintable characters
set listchars=tab:>.,trail:.,extends:#,nbsp:.   "highlight whitespaces

"SEARCH
set nohlsearch                  "don't highlight search results
set incsearch                   "show match as search proceeds
set ignorecase                  "case insensitive searches
set smartcase                   "case sensitive if caps are used

"BEHAVIOUR
set splitbelow
set splitright
set hidden                      "use buffer for unwritten changes
set backspace=indent,eol,start  "make backspace work like in other text editors
set encoding=utf-8              "character encoding
set tw=1000                     "max line length before moving to newline
set pastetoggle=<F5>            "key for toggling paste mode
nmap <silent> ,/ :hlsearch<CR>
cmap w!! w !sudo tee % >/dev/null
nnoremap ; :

"NAVIGATION
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"FOLDING
set foldmethod=indent           "fold based on indent
set foldnestmax=10              "deepest fold is 10 levels
set nofoldenable                "don't fold by default
set foldlevel=1

"REMAPS
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> :TagbarToggle<CR>

"NERDTREE
let g:NERDTreeWinSize = 31                          "adjust window size
let NERDTreeMapPreview = 'n'                        "remap preview key
let NERDTreeIgnore=['\.pyc$', '\.swp$', '\~$']      "file types to ignore

"CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll|class|jar|tar.gz|tgz|swp|swo|pyc|pyo)$',
            \ }

"Tagbar
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

highlight SpellBad term=reverse ctermbg=5
highlight MatchParen gui=bold guibg=NONE guifg=lightblue cterm=bold ctermbg=NONE

"FUNCTIONS
set number
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
au FocusLost * :set number
au FocusGained * :set relativenumber

highlight NonText guibg=NONE ctermbg=NONE
highlight Normal guibg=NONE ctermbg=NONE
