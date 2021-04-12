" nvim/init.vim
" Wibowo Arindrarto <contact@arindrarto.dev>

let g:python3_host_prog = '/usr/bin/python3'

" Load plugins
call plug#begin(stdpath('data') . '/plugged')
    Plug 'sheerun/vim-polyglot', { 'tag': 'v4.2.1' }
    Plug 'dense-analysis/ale', { 'tag': 'v2.6.0' }
    Plug 'neoclide/coc.nvim', {'branch': 'v0.0.80'}
    Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}

    Plug 'jiangmiao/auto-pairs', { 'tag': 'v2.0.0' }
    Plug 'kien/ctrlp.vim', { 'commit': '564176f01d7f3f7f8ab452ff4e1f5314de7b0981' }
    Plug 'vim-airline/vim-airline', { 'tag': 'v0.11' }
    Plug 'vim-airline/vim-airline-themes', { 'commit': '3fb676b8729a98817f561ef1554c0ad1a514c96a' }
    Plug 'tpope/vim-commentary', { 'commit': 'f8238d70f873969fb41bf6a6b07ca63a4c0b82b1' }
    Plug 'tpope/vim-fugitive', { 'tag': 'v3.2' }
    Plug 'nathanaelkane/vim-indent-guides', { 'commit': '54d889a63716ee2f1818aa2ec5082db47147147b' }
    Plug 'kevinoid/vim-jsonc', { 'commit': '67d26459fb64236681fb600b610cd56eaeb43999' }
    Plug 'farmergreg/vim-lastplace', { 'tag': 'v3.2.1' }
    Plug 'ledger/vim-ledger', { 'commit': 'b3e6f3dfaa922cda7771a4db20d3ae0267e08133' }
    Plug 'kburdett/vim-nuuid', { 'commit': '6ae845f9348921f4e436c587da6d2bbf5691c4ed' }
    Plug 'kshenoy/vim-signature', { 'commit': '6bc3dd1294a22e897f0dcf8dd72b85f350e306bc' }
    Plug 'mhinz/vim-signify', { 'tag': 'stable' }
    Plug 'mhinz/vim-startify', { 'commit': '593388d3dbe7bfdcc06a714550d3253442b2fc65' }
    Plug 'tpope/vim-surround', { 'commit': 'f51a26d3710629d031806305b6c8727189cd1935' }
    Plug 'easymotion/vim-easymotion', { 'commit': 'd75d9591e415652b25d9e0a3669355550325263d' }

    Plug 'Glench/Vim-Jinja2-Syntax', { 'commit': 'ceb0f8076ee9aa802668448cefdd782edff4f6b2' }
    Plug 'kien/rainbow_parentheses.vim', { 'commit': 'eb8baa5428bde10ecc1cb14eed1d6e16f5f24695' }
    Plug 'morhetz/gruvbox', { 'commit': '040138616bec342d5ea94d4db296f8ddca17007a' }
    Plug 'liuchengxu/graphviz.vim', { 'commit': '704aa42852f200db2594382bdf847a92fdab61fc' }
call plug#end()

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

    au FileType asciidoc setlocal ts=2 sw=2 tw=90 wrap commentstring=//\ %s
    au BufNewFile,BufRead *.adoc,*.asciidoc setlocal ft=asciidoc

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

    au FileType markdown setlocal ts=2 sw=2 tw=90 wrap
    au BufNewFile,BufRead *.md,*.MD setlocal ft=markdown

    au FileType plaintex setlocal ts=2 sw=2 tw=100 wrap
    au BufNewFile,BufRead *.tex setlocal ft=plaintex

    au FileType refFlat setlocal wrap linebreak noexpandtab
    au BufNewFile,BufRead *.refFlat setlocal ft=refFlat

    au FileType rst setlocal ts=2 sw=2 tw=90 wrap
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
    au FileType html,htmljinja,jinja setlocal ts=2 sw=2
    au FileType mako setlocal ts=2 sw=2
    au FileType json setlocal ts=2 sw=2
    au FileType php setlocal tw=100 ts=2 sw=2
    au FileType proto setlocal tw=100
    au FileType python setlocal indentkeys-=<:> indentkeys-=: tw=88
    au FileType ruby setlocal tw=80 ts=2 sw=2
    au FileType sql setlocal commentstring=--\ %s
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
    au BufNewFile,BufRead Tiltfile,Tiltfile.* setlocal ft=bzl
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
\   'c': [],
\   'cpp': ['clangtidy'],
\   'elixir': [],
\   'go': ['gofmt', 'govet'],
\   'plaintex': [],
\   'python': ['flake8'],
\   'rust': ['cargo'],
\   'tex': [],
\   'typescript': ['eslint', 'prettier'],
\}
let g:ale_fixers = {
\   'go': ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace'],
\   'python': ['isort'],
\}
let g:ale_fix_on_save = 1

let g:ale_html_tidy_options = '-q -e -language en --drop-empty-elements no'

let g:ale_cpp_clangtidy_checks = ['-llvm-header-guard']

" let g:ale_sign_error = ''
" let g:ale_sign_warning = ''
let g:ale_sign_error = '➡'
let g:ale_sign_warning = '➡'
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
hi SignifySignAdd    gui=bold guifg=#262626 guibg=#427b58
hi SignifySignDelete gui=bold guifg=#262626 guibg=#af3a03
hi SignifySignChange gui=bold guifg=#262626 guibg=#b57614
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
        \|mp4|mkv|avi|mpg
        \|mp3|flac
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


" Settings for coc.nvim ~ adapted from their wiki.
let g:coc_global_extensions = [
\   'coc-eslint',
\   'coc-css',
\   'coc-html',
\   'coc-json',
\   'coc-prettier',
\]

" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

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
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
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
nnoremap <silent> <A-a>  :<C-u>CocList diagnostics<cr>
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
" ALE colors
hi ALEInfo guifg=#1d2021 guibg=#458588 gui=bold
hi ALEInfoSign guifg=#458588 guibg=#262626 gui=none
hi ALEWarning guifg=#1d2021 guibg=#d79921 gui=bold
hi ALEWarningSign guifg=#d79921 guibg=#262626 gui=none
hi ALEError guifg=#1d2021 guibg=#cc241d gui=bold
hi ALEErrorSign guifg=#cc241d guibg=#262626 gui=none
" Coc colors"
hi CocHintHighlight guifg=#1d2021 guibg=#98971a gui=bold
hi CocInfoHighlight guifg=#1d2021 guibg=#458588 gui=bold
hi CocInfoSign guifg=#458588 guibg=#262626 gui=none
hi CocWarningHighlight guifg=#1d2021 guibg=#d79921 gui=bold
hi CocWarningSign guifg=#d79921 guibg=#262626 gui=none
hi CocErrorHighlight guifg=#1d2021 guibg=#cc241d gui=bold
hi CocErrorSign guifg=#cc241d guibg=#262626 gui=none
