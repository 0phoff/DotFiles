" -------------------------------------------------------------------------------------------------------------------------------------------------------------
"       _  _  _         _  _                                                                 _  _  _  _                              _                         
"    _ (_)(_)(_) _     (_)(_)                                                               (_)(_)(_)(_)_                           (_)                        
"   (_)         (_)       (_)           _  _  _          _  _  _  _        _  _  _  _       (_)        (_)      _  _  _           _  _        _       _  _     
"   (_)                   (_)        _ (_)(_)(_) _     _(_)(_)(_)(_)      (_)(_)(_)(_)_     (_) _  _  _(_)     (_)(_)(_) _       (_)(_)      (_)_  _ (_)(_)    
"   (_)                   (_)       (_)         (_)   (_)_  _  _  _      (_) _  _  _ (_)    (_)(_)(_)(_)        _  _  _ (_)         (_)        (_)(_)          
"   (_)          _        (_)       (_)         (_)     (_)(_)(_)(_)_    (_)(_)(_)(_)(_)    (_)               _(_)(_)(_)(_)         (_)        (_)             
"   (_) _  _  _ (_)     _ (_) _     (_) _  _  _ (_)      _  _  _  _(_)   (_)_  _  _  _      (_)              (_)_  _  _ (_)_      _ (_) _      (_)             
"      (_)(_)(_)       (_)(_)(_)       (_)(_)(_)        (_)(_)(_)(_)       (_)(_)(_)(_)     (_)                (_)(_)(_)  (_)    (_)(_)(_)     (_)             
"                                                                                                                                                              
" -------------------------------------------------------------------------------------------------------------------------------------------------------------

if exists("g:ClosePairKeyMapping")
    finish
endif
let g:ClosePairKeyMapping = 1

function! ClosePair#KeyMapping#RemoveEmptyPair()
    let prev = matchstr(getline('.'), '\%' . (col('.')-1) . 'c.')
    let next = matchstr(getline('.'), '\%' . (col('.')) . 'c.')

    for p in b:CP_Pairs
        if p[0] == prev && p[1] == next
            return "\<RIGHT>" . "\<BS>\<BS>"
        endif
    endfor

    return ""
endfunction

function! ClosePair#KeyMapping#IndentInsideCurlyBracket()
    let prev = matchstr(getline('.'), '\%' . (col('.')-1) . 'c.')
    let next = matchstr(getline('.'), '\%' . (col('.')) . 'c.')

    if prev == '{' && next == '}'
        return "\<CR>\<CR>\<UP>\<RIGHT>\<TAB>"
    else
        return ""
    endif
endfunction

function! ClosePair#KeyMapping#JumpOutPair()
    let prevSearch = @/
    let highlight = &hlsearch
    set nohlsearch
    
    " Create Regex to find closing Pair on the line
    let regex = "["
    for p in b:CP_Pairs
        let regex = regex . '\' . p[1]
    endfor
    let regex = regex . "]"

    " Find next closing pair
    silent! exec "normal! v$oh\<ESC>/\\%V\\v".regex."\<CR>"

    let @/ = prevSearch
    let &hlsearch = highlight
    return "\<RIGHT>"
endfunction
