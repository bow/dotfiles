"GO
set rtp+=$GOROOT/misc/vim

"DISPLAY
"color ir_black                  "color scheme
set background=light
syntax on                       "turns on color syntax in various programming languages
filetype indent on              "enable autoindenting for specific filetypes
filetype plugin on              "enable filetype specific plugins
filetype on                     "detect file extension
set relativenumber              "show line number
set showcmd                     "show entered command

"FILETYPE-SPECIFIC
au BufRead,BufNewFile *.mkc setlocal filetype=make tw=200
au BufRead,BufNewFile *.mkn setlocal filetype=make tw=200
au BufRead,BufNewFile *.mki setlocal filetype=make tw=200
au BufRead,BufNewFile *.jdl setlocal filetype=jdl tw=200
au BufRead,BufNewFile *.json setlocal filetype=javascript tabstop=2 shiftwidth=2 tw=1000
autocmd FileType go setlocal noexpandtab tabstop=4 tw=150
autocmd FileType py setlocal tw=80
autocmd FileType rst setlocal tw=80
autocmd FileType markdown  setlocal shiftwidth=2 tabstop=2
autocmd FileType md setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2
autocmd FileType php setlocal shiftwidth=2 tabstop=2
autocmd FileType mako setlocal shiftwidth=2 tabstop=2
autocmd FileType R setlocal shiftwidth=2 tabstop=2
autocmd FileType c setlocal shiftwidth=2 tabstop=2
autocmd FileType cfg setlocal shiftwidth=2 tabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2
autocmd FileType scala setlocal shiftwidth=2 tabstop=2
autocmd FileType xhtml, xml so ~/.vim/ftplugin/html_autoclosetag.vim

"SPACES & INDENTS
set autoindent                  "turns on autoindent
set expandtab                   "use spaces instead of actual tabs
set shiftwidth=4                "indenting is 4 spaces
set cindent                     "turns on cindent
set tabstop=4                   "tabs are replaced by 4 spaces

"SEARCH
set hlsearch                    "highlight search results
set incsearch                   "show match as search proceeds
set ignorecase                  "case insensitive searches
set smartcase                   "case sensitive if caps are used

"BEHAVIOUR
set backspace=indent,eol,start  "make backspace work like in other text editors
set encoding=utf-8              "character encoding
set tw=1000                     "max line length before moving to newline

"FOLDING
set foldmethod=indent           "fold based on indent
set foldnestmax=10              "deepest fold is 10 levels
set nofoldenable                "don't fold by default
set foldlevel=1

"REMAPS
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> :TlistToggle<CR>
nnoremap <F5> :TlistShowPrototype<CR>

"PLUGINS
call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()          
let vimrplugin_screenplugin = 0

"NERDTREE
let g:NERDTreeWinSize = 35                          "adjust window size
let NERDTreeMapPreview = 'n'                        "remap preview key
let NERDTreeIgnore=['\.pyc$', '\.swp$', '\~$']      "file types to ignore

"TAGLIST
" TagList options
let Tlist_Close_On_Select = 1               "close taglist window once we selected something
let Tlist_Exit_OnlyWindow = 1               "if taglist window is the only window left, exit vim
let Tlist_Show_Menu = 1                     "show Tags menu in gvim
let Tlist_GainFocus_On_ToggleOpen = 1       "automatically switch to taglist window
let Tlist_Highlight_Tag_On_BufEnter = 1     "highlight current tag in taglist window
let Tlist_Process_File_Always = 1           "even without taglist window, create tags file, required for displaying tag in statusline
let Tlist_WinWidth = 40                      "adjust window size
let Tlist_Show_One_File = 1                 "show tags of only one file
"let Tlist_Display_Prototype = 1             "display full prototype instead of just function name

set statusline=[%n]\ %<%f\ %([%1*%M%*%R%Y]%)\ \ \ [%{Tlist_Get_Tagname_By_Line()}]\ %=%-19(\LINE\ [%l/%L]\ COL\ [%02c%03V]%)\ %P
highlight SpellBad term=reverse ctermbg=5
highlight MatchParen gui=bold guibg=NONE guifg=lightblue cterm=bold ctermbg=NONE

"FUNCTIONS
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
:au FocusLost * :set number
:au FocusGained * :set relativenumber
