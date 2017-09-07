" Markdown Settings
if exists('b:did_ftplugin') | finish | endif

setlocal shiftwidth=2
setlocal tabstop=2

if !exists('b:CP_Pairs')
  let b:CP_Pairs = []
  call CP_UpdatePairs(g:CP_PairsDefault)
endif
call CP_AddPair('_', '_')
call CP_AddPair('~', '~')

setlocal foldexpr=MarkdownLevel()
setlocal foldmethod=expr

function! MarkdownLevel()
    let str = getline(v:lnum)
    let h = substitute(matchstr(str, '^\s*#\+'), '\s', '', "g")

    if (empty(h))
        if ((empty(str) && empty(getline(v:lnum+1))) || matchstr(str, '^\s*[\-_]{3,}\s*$'))
          return '<'
        else
          return '='
        endif
    else
        return ">" . len(h)
    endif
endfunction

" Settings loaded buffer flag
let b:did_ftplugin = 1
