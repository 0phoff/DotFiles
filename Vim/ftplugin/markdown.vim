" Markdown Settings
if exists('b:did_ftplugin_pers') | finish | endif

setlocal shiftwidth=2
setlocal tabstop=2

if !exists('b:CP_Pairs')
  let b:CP_Pairs = []
  call CP_UpdatePairs(g:CP_PairsDefault)
endif
call CP_AddPair('_', '_')
call CP_AddPair('~', '~')

iabbrev <buffer> -> →
iabbrev <buffer> <- ←
iabbrev <buffer> << «
iabbrev <buffer> >> »

setlocal foldmethod=expr
setlocal foldexpr=MarkdownLevel(v:lnum)
function! MarkdownLevel(lineNo)
  let str = getline(a:lineNo)

  " Empty lines → -1 → get smallest fold level from line above or below
  if str =~? '\v^\s*$'
    return '-1'
  endif

  " Header → >x → Start fold of lvl equal to heading
  if str =~? '\v^\s*#+'
    let lvl = len(matchlist(str, '\v^\s*(#+)')[1])
    return '>'.lvl
  endif

  " ---/___ → 0 → Stop all folds
  if str =~? '\v^\s*[\-_]{3,}\s*$'
    return '0'
  endif

  return '='
endfunction

" Settings loaded buffer flag
let b:did_ftplugin_pers = 1
