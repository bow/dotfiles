" .vimrc
" Wibowo Arindrarto <bow@bow.web.id>
""""""""""""""""""""""""""""""""""""

" Setup Pathogen.
call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()


" Enable local .vimrc use.
set exrc

" Restrict some command in non-default .vimrc.
set secure

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

" Enable file type-specific autoindenting.
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

    au FileType markdown setlocal ts=2 sw=2 tw=0 wrap
    au BufNewFile,BufRead *.md,*.MD setlocal ft=markdown

    au FileType plaintex setlocal ts=2 sw=2 tw=100 wrap
    au BufNewFile,BufRead *.tex setlocal ft=plaintex

    au FileType refFlat setlocal wrap linebreak noexpandtab
    au BufNewFile,BufRead *.refFlat setlocal ft=refFlat

    au FileType rst setlocal ts=2 sw=2 tw=0 wrap
    au BufNewFile,BufRead *.rst,*.RST setlocal ft=rst

    au FileType sam setlocal wrap linebreak noexpandtab
    au BufNewFile,BufRead *.sam setlocal ft=sam

    au FileType scala setlocal tw=120 ts=2 sw=2
    au BufNewFile,BufRead *.scala,*.sc setlocal ft=scala

    au FileType snakemake setlocal tw=100
    au BufNewFile,BufRead Snakefile,Snakefile.*,*.snakefile,*.snake,*.rule,*.rules setlocal ft=snakemake

    au FileType text setlocal wrap

    au FileType typescript setlocal tw=100 ts=4 sw=4
    au BufNewFile,BufRead *.ts setlocal ft=typescript

    au FileType tsv setlocal wrap linebreak noexpandtab
    au BufNewFile,BufRead *.tsv setlocal ft=tsv

    au FileType yaml setlocal ts=2 sw=2 indentkeys-=<:>
    au BufNewFile,BufRead *.yml,*.yaml setlocal ft=yaml

    au FileType wdl setlocal tw=100 ts=2 sw=2 nocindent
    au BufNewFile,BufRead *.wdl setlocal ft=wdl

    au FileType bib setlocal ts=2 sw=2 tw=100
    au FileType c setlocal tw=100
    au FileType cfg setlocal ts=2 sw=2
    au FileType cpp setlocal tw=100
    au FileType css setlocal tw=100 ts=2 sw=2
    au FileType dockerfile setlocal tw=100
    au FileType scss setlocal tw=100 ts=2 sw=2
    au FileType elixir setlocal tw=100
    au FileType erlang setlocal tw=100 ts=2 sw=2
    au Filetype gitcommit setlocal spell tw=72
    au FileType hocon setlocal ts=2 sw=2
    au FileType go setlocal tw=100 noexpandtab nolist
    au FileType html,htmljinja setlocal ts=2 sw=2
    au FileType mako setlocal ts=2 sw=2
    au FileType json setlocal ts=2 sw=2
    au FileType php setlocal tw=100 ts=2 sw=2
    au FileType ruby setlocal tw=80 ts=2 sw=2
    au FileType python setlocal indentkeys-=<:> indentkeys-=: tw=80
    au FileType R setlocal tw=100 ts=2 sw=2
    au FileType tex setlocal ts=2 sw=2 tw=100 wrap
    au FileType xml setlocal ts=2 sw=2
    au FileType xml,xhtml,htmljinja so ~/.vim/ftplugin/html_autoclosetag.vim

    au BufNewFile,BufRead *.cool,*.cl setlocal ft=cool
    au BufNewFile,BufRead *.cwl setlocal ft=yaml
    au BufNewFile,BufRead .envrc setlocal ft=bash
    au BufNewFile,BufRead *.jdl setlocal ft=jdl
    au BufNewFile,BufRead *.jsonl setlocal ft=json
    au BufNewFile,BufRead *.hs setlocal ft=haskell
    au BufNewFile,BufRead *.lgr setlocal ft=ledger
    au BufNewFile,BufRead *.mdj setlocal ft=json
    au BufNewFile,BufRead *.lalrpop setlocal ft=rust
    au BufNewFile,BufRead Pipfile setlocal ft=toml
    au BufNewFile,BufRead Pipfile.lock setlocal ft=json
    au BufNewFile,BufRead *.rl setlocal ft=ragel
    au BufNewFile,BufRead Vagrantfile setlocal ft=ruby

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

" Update Ale colors.
hi ALEWarning ctermbg=172 ctermfg=black
hi ALEWarningSign ctermbg=172 ctermfg=black
hi ALEError ctermbg=88 ctermfg=white
hi ALEErrorSign ctermbg=88 ctermfg=white

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
let g:indent_guides_exclude_filetypes = ['help']
let g:indent_guides_guide_size = 4
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
au VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#1d2021 ctermbg=NONE
au VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#262626 ctermbg=234

" Setup Ale
let g:ale_linters = {
\   'cpp': ['clangtidy'],
\   'elixir': [],
\   'go': ['gofmt', 'govet'],
\   'plaintex': [],
\   'tex': [],
\   'typescript': ['eslint', 'prettier'],
\}
let g:ale_fixers = {
\   'go': ['gofmt', 'remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_fix_on_save = 1
let g:ale_cpp_clangtidy_checks = ['-llvm-header-guard']

let g:ale_sign_error = '✕'
let g:ale_sign_warning = '≫'
let g:ale_sign_column_always = 1
let g:ale_set_quickfix = 1
let g:ale_set_loclist = 0

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '%linter%: %s [%code%]'

let g:airline#extensions#ale#enabled = 1

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif


" Set default SQL file types to PostgreSQL
let g:sql_type_default = 'pgsql'

" Disable vim-r-plugin integration with screen.vim
let vimrplugin_screenplugin = 0
let g:vimrplugin_term = "termite"

" Disable '_' auto replacement with '<-' in R files.
let g:vimrplugin_underscore = 0

" Setup vim-signify.
let g:signify_vcs_list = [ 'git' ]
hi SignifySignAdd    gui=bold guifg=#111111 guibg=#427b58
hi SignifySignDelete gui=bold guifg=#111111 guibg=#af3a03
hi SignifySignChange gui=bold guifg=#111111 guibg=#b57614
let g:signify_sign_delete = '-'

" List of excluded name patterns in editorconfig-vim.
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


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
        \|swp|swo|whl
        \|pyc|pyo|jar|class
        \|tgz|tar|zip|gz|gzip|bz2|xz
        \)$',
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
nnoremap <F4> :TagbarToggle<CR>

" Remaps - shortcuts for dropdown popups.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Remaps - command mode.
cnoremap w!! w !sudo tee % >/dev/null

" Remaps - quickfix and location list toggles.
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(
    \ filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'),
    \ 'str2nr(matchstr(v:val, "\\d\\+"))'
    \ )
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>
