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
"
"  ClosePair Script : Automatically close matching pairs
"  By 0phoff
"  Version 2.1
"
" -------------------------------------------------------------------------------------------------------------------------------------------------------------
"
"  Features:
"   - Automatically close matching pairs when double tapping the opening tab (eg: writes [] when typing [[)
"   - List of tags can be updated for every seperate buffer (usefull with ftplugin)
"   - Delete pair when empty and deleting the first one
"   - Surround a visual selection with a pair
"   - Function to jump behind closed tab
"
" -------------------------------------------------------------------------------------------------------------------------------------------------------------

" Global Variables {{{

if !exists("g:CP_PairsDefault")
    let g:CP_PairsDefault = [ ['{','}'], ['[',']'], ['(',')'], ["'","'"], ['"','"'], ["<",">"] ]
endif
if !exists("g:CP_SurroundKey")
    let g:CP_SurroundKey = "s"
endif

" }}}


" Init Functions {{{

function! s:CP_Init()
    if !exists("b:CP_Pairs")
        let b:CP_Pairs = []
        call CP_UpdatePairs(g:CP_PairsDefault)
    endif
endfunction

function! CP_UpdatePairs(pairs)
    for p in b:CP_Pairs
        exec "iunmap <buffer>".p[0].p[0]
        exec "vunmap <buffer>".g:CP_SurroundKey.p[0]
    endfor

    for p in a:pairs
        exec "inoremap <silent><expr><buffer>" . p[0].p[0] . " CP_Close(\"\\" . p[0]."\",\"\\".p[1]."\")"
        exec "vnoremap <silent><buffer>" . g:CP_SurroundKey . p[0] . " c" . p[0].p[1]. "<ESC>P"
    endfor

    let b:CP_Pairs = a:pairs
endfunction

function! CP_Close(open,close) 
    return a:open.a:close."\<LEFT>"
endfunction

" }}}


" Autoload Functions {{{

function! CP_AddPair(p1, p2)
    call ClosePair#ChangePairs#Add(a:p1, a:p2)
endfunction

function! CP_RemPair(p1)
    call ClosePair#ChangePairs#Remove(a:p1)
endfunction

function! CP_RemoveEmptyPair()
    return ClosePair#KeyMapping#RemoveEmptyPair()
endfunction

function! CP_IndentInsideCurlyBracket()
    return ClosePair#KeyMapping#IndentInsideCurlyBracket()
endfunction

function! CP_JumpOutPair()
    return ClosePair#KeyMapping#JumpOutPair()
endfunction

" }}}


" Autocommands {{{

augroup CP_AutoCmds
    autocmd!
    autocmd BufEnter * :call s:CP_Init()
augroup END

" }}}
