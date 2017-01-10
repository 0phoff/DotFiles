" Markdown Specific Settings

setlocal shiftwidth=2
setlocal tabstop=2

setlocal foldexpr=MarkdownLevel()
setlocal foldmethod=expr

function! MarkdownLevel()
    let h = substitute(matchstr(getline(v:lnum), '^\s*#\+'), '\s', '', "g")

    if (empty(h))
        return '='
    else
        return ">" . len(h)
    endif
endfunction
