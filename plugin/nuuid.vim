if exists('g:nuuid_loaded') && g:nuuid_loaded
	finish
endif
let g:nuuid_loaded = 1

if !exists('g:nuuid_case')
	let g:nuuid_case = "lower"
endif

" Make sure we have python
if !has('python')
	" finish
endif

" Use python to generate a new UUID
function! NuuidNewUuid()
  if executable('uuidgen')
    let l:new_uuid=system('uuidgen')[:-2]
    return g:nuuid_case == "lower" ? tolower(l:new_uuid) : toupper(l:new_uuid)
  else
python << endpy
import vim
from uuid import uuid4
vim.command("let l:new_uuid = '%s'"% str(uuid4()))
endpy
    return g:nuuid_case == "lower" ? tolower(l:new_uuid) : toupper(l:new_uuid)
  endif
endfunction


function! s:NuuidInsertAbbrev()
	inoreabbrev <expr> nuuid NuuidNewUuid()
	inoreabbrev <expr> nguid NuuidNewUuid()
	let g:nuuid_iabbrev = 1
endfunction

function! s:NuuidInsertUnabbrev()
	silent iunabbrev nuuid
	silent iunabbrev nguid
	let g:nuuid_iabbrev = 0
endfunction

function! s:NuuidToggleInsertAbbrev()
	if exists('g:nuuid_iabbrev') && g:nuuid_iabbrev
		call s:NuuidInsertUnabbrev()
	else
		call s:NuuidInsertAbbrev()
	endif
endfunction

" set the initial abbreviation state
if !exists('g:nuuid_iabbrev') || g:nuuid_iabbrev
	call s:NuuidInsertAbbrev()
else
	call s:NuuidInsertUnabbrev()
endif

" commands
command! -nargs=0 NuuidToggleAbbrev call s:NuuidToggleInsertAbbrev()
command! -range -nargs=0 NuuidAll <line1>,<line2>substitute/\v<n[ug]uid>/\=NuuidNewUuid()/geI
command! -range -nargs=0 NuuidReplaceAll <line1>,<line2>substitute/\v<([0-9a-f]{8}\-?([0-9a-f]{4}\-?){3}[0-9a-f]{12}|n[gu]uid)>/\=NuuidNewUuid()/geI

" Mappings
nnoremap <Plug>Nuuid i<C-R>=NuuidNewUuid()<CR><Esc>
inoremap <Plug>Nuuid <C-R>=NuuidNewUuid()<CR>
vnoremap <Plug>Nuuid c<C-R>=NuuidNewUuid()<CR><Esc>

if !exists("g:nuuid_no_mappings") || !g:nuuid_no_mappings
	nmap <Leader>u <Plug>Nuuid
	vmap <Leader>u <Plug>Nuuid
endif
