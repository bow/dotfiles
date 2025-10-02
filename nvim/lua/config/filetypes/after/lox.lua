return function()

  vim.cmd [=[
if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword loxKeywordClass class
syn keyword loxKeywordFunction fun
syn keyword loxKeywordIdentifier var
syn keyword loxKeywordConditional if else
syn keyword loxKeywordLoop for while
syn keyword loxKeywordBranch return
syn keyword loxKeyword print nil this super
syn keyword loxKeywordBoolean true false

" Matches
syn match loxLineComment "\/\/.*"
syn match loxCommentSkip "^[ \t]*\*\($\|[ \t]\+\)"
syn match loxNumber "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn match loxNumber "-\=\<\d\+\%(_\d\+\)*\>"
syn match loxBraces "[{}\[\]]"

" Regions
syn region loxComment start="/\*" end="\*/"
syn region loxString start=+"+ skip=+\\\\\|\\"+ end=+"\|$+

" Highlights
hi link loxKeyword Keyword
hi link loxKeywordFunction Function
hi link loxKeywordClass Function
hi link loxKeywordConditional Conditional
hi link loxKeywordIdentifier Identifier
hi link loxKeywordLoop Repeat
hi link loxKeywordBoolean Boolean
hi link loxKeywordBranch Statement
hi link loxComment Comment
hi link loxLineComment Comment

hi link loxString String
hi link loxNumber Number
hi link loxBraces Function
]=]
end
