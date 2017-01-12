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

if exists("g:ClosePair_ChangePairs")
    finish
endif
let g:ClosePair_ChangePairs = 1


function! ClosePair#ChangePairs#Add(p1, p2)
    for p in b:CP_Pairs
        if p[0] == a:p1
            return
        endif
    endfor

    exec "inoremap <silent><expr><buffer>" . a:p1.a:p1 . " CP_Close(\"\\" . a:p1."\",\"\\".a:p2."\")"
    exec "vnoremap <silent><buffer>" . g:CP_SurroundKey . a:p1 . " c" . a:p1.a:p2. "<ESC>P"

    let b:CP_Pairs = b:CP_Pairs + [[a:p1, a:p2]]
endfunction

function! ClosePair#ChangePairs#Remove(p1)
    for p in b:CP_Pairs
        if p[0] == a:p1
            let idx = index(b:CP_Pairs,p)
            exec "iunmap <buffer>".p[0].p[0]
            exec "vunmap <buffer>".g:CP_SurroundKey.p[0]
            break
        endif
    endfor

    if exists("idx")
        let b:CP_Pairs = b:CP_Pairs[:(idx-1)] + b:CP_Pairs[(idx+1):]
    endif
endfunction

