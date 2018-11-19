" ---------------------------------------------------------------------------------------------------------------
"      _   ___  ___ ___ ___    ___ _____ _ _____ _   _ ___ 
"     /_\ / __|/ __|_ _|_ _|  / __|_   _/_\_   _| | | / __|
"    / _ \\__ \ (__ | | | |   \__ \ | |/ _ \| | | |_| \__ \
"   /_/ \_\___/\___|___|___|  |___/ |_/_/ \_\_|  \___/|___/
"                                                       
" ---------------------------------------------------------------------------------------------------------------
"
"  Ascii Statusline and Tabline
"  By 0phoff
"  Version 1.1
"
" ---------------------------------------------------------------------------------------------------------------

" Constants             {{{

let s:nord0  = ["#2E3440", "NONE"]
let s:nord1  = ["#3B4252", "0"]
let s:nord2  = ["#434C5E", "NONE"]
let s:nord3  = ["#4C566A", "8"]
let s:nord4  = ["#D8DEE9", "NONE"]
let s:nord5  = ["#E5E9F0", "7"]
let s:nord6  = ["#ECEFF4", "15"]
let s:nord7  = ["#8FBCBB", "14"]
let s:nord8  = ["#88C0D0", "6"]
let s:nord9  = ["#81A1C1", "4"]
let s:nord10 = ["#5E81AC", "12"]
let s:nord11 = ["#BF616A", "1"]
let s:nord12 = ["#D08770", "11"]
let s:nord13 = ["#EBCB8B", "3"]
let s:nord14 = ["#A3BE8C", "2"]
let s:nord15 = ["#B48EAD", "5"]
let g:mode_mappings = {
  \ 'n'   : 'Normal',
  \ 'no'  : 'N·Operator Pending',
  \ 'v'   : 'Visual',
  \ 'V'   : 'V·Line',
  \ '^V'  : 'V·Block',
  \ 's'   : 'Select',
  \ 'S'   : 'S·Line',
  \ '^S'  : 'S·Block',
  \ 'i'   : 'Insert',
  \ 'R'   : 'Replace',
  \ 'Rv'  : 'V·Replace',
  \ 'c'   : 'Command',
  \ 'cv'  : 'Vim Ex',
  \ 'ce'  : 'Ex',
  \ 'r'   : 'Prompt',
  \ 'rm'  : 'More',
  \ 'r?'  : 'Confirm',
  \ '!'   : 'Shell',
  \ 't'   : 'Terminal'
  \}

" ----------------------}}}


" Helper functions      {{{

function! s:setHiGroup(nr, fg, bg)
  exe 'hi User' . a:nr . ' ctermfg=' . a:fg[1] . ' ctermbg=' . a:bg[1] . ' guifg=' . a:fg[0] . ' guibg=' . a:bg[0]
endfunction

function! s:color(active, nr, content)
  if a:active
    return '%' . a:nr . '*' . a:content . '%*'
  else
    return a:content
  endif
endfunction

function! s:refreshstatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!SL_Statusline(' . nr . ')')
  endfor
endfunction

" ----------------------}}}


" Highlight groups      {{{

call s:setHiGroup(1, s:nord3,  s:nord1)   " Decorations group
call s:setHiGroup(2, s:nord9,  s:nord1)   " Main text group
call s:setHiGroup(3, s:nord8,  s:nord1)   " Special text group
call s:setHiGroup(4, s:nord15, s:nord1)   " Selected text group
call s:setHiGroup(5, s:nord14, s:nord1)   " Green text
call s:setHiGroup(6, s:nord13, s:nord1)   " Yellow text
call s:setHiGroup(7, s:nord11, s:nord1)   " Red text
call s:setHiGroup(8, s:nord1, s:nord1)    " Invisible text

" ----------------------}}}


" Setup statusline      {{{

function! SL_Statusline(nr) abort
  let s = ''
  let active = a:nr == winnr()

  " Status functions    {{{
  function! SL_Mode() abort
    let l:modecurrent = mode()
    let l:modelist = toupper(get(g:mode_mappings, l:modecurrent, 'V·Block'))
    return l:modelist
  endfunction
  
  function! SL_FileMod(nr) abort
    if &readonly || !&modifiable
      if a:nr == 3
        return ''
      endif
    elseif &modified
      if a:nr == 2
        return ''
      endif
    else
      if a:nr == 1
        return ''
      endif
    endif
    return ''
  endfunction
  
  function! SL_FileType() abort
    let type = &ft
    if type == ''
      return '─'
    else
      return type
    endif
  endfunction
  
  function! SL_FilePath() abort
      let pwd = getcwd()
      let fileDir = expand('%:p:h')
      let i = match(fileDir, pwd)
      if (i == -1)
        return fileDir
      elseif (len(pwd) == len(fileDir))
        return './'
      else
        return '.' . fileDir[i+len(pwd):]
      endif
  endfunction
  
  function! SL_CWD() abort
    return split(getcwd(), '/')[-1]
  endfunction
  " --------------------}}}

  " Left
  let s .= '[' . s:color(active, 3, '%{SL_Mode()}') . ']'       " Mode
  let s .= '%<╾─╼'                                              " Separator
  let s .= '[' . s:color(active, 2, '%t') . ']'                 " Filename
  let s .= '['
  let s .= s:color(active, 5, '%{SL_FileMod(1)}')               " File saved
  let s .= s:color(active, 6, '%{SL_FileMod(2)}')               " File modified
  let s .= s:color(active, 7, '%{SL_FileMod(3)}')               " File locked
  let s .= ']%8*%=%*'
  
  " Right
  let s .= '[' . s:color(active, 2, '%{SL_FileType()}') . ']'   " Filetype
  let s .= '╾─╼'                                                " Separator
  let s .= '[' . s:color(active, 2, '%{SL_FilePath()}') . ']'   " Path to file
  let s .= '[' . s:color(active, 2, '%{SL_CWD()}') . ']'        " Current working directory
  let s .= '╾─╼'                                                " Separator
  let s .= '[' . s:color(active, 3, '%04l %03v') . ']'        " Cursor position

  return s
endfunction

hi! link StatusLine   User1
hi! link StatusLineNC User1

augroup ls_status
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * call <SID>refreshstatus()
augroup END


" ----------------------}}}


" Setup tabline         {{{

function! SL_Tabline() abort
  let s = ''
  let t = tabpagenr()

  for i in range(tabpagenr('$'))
    let tabnr = i + 1     " Range starts at zero

    " Insert TabNumber
    let s .= '%' . tabnr . 'T'
    let s .= '['
    let s .= (tabnr == t ? '%4*' : '%2*')
    let s .= tabnr
    let s .= '%* ─ '
    let s .= (tabnr == t ? '%4*' : '%2*')

    " Insert BufferName
    let file = gettabvar(tabnr, 'tabname')
    if file == ''
      let buflist = tabpagebuflist(tabnr)
      let winnr = tabpagewinnr(tabnr)
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, '&buftype')

      
      if buftype == 'help'
        let file = 'help:' . fnamemodify(file, ':t:r')
      elseif buftype == 'quickfix'
        let file = 'quickfix'
      elseif buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif
      else
        let file = pathshorten(fnamemodify(file, ':p:~:.'))
      endif
      if file == ''
        let file = '[No Name]'
      endif
    endif

    let s .= file
    let s .= '%*]'
    let s .= '%T'
  endfor

  let s .= '%='
  let s .= (tabpagenr('$') > 1 ? '%999XX%X' : '')

  return s
endfunction

hi! link TabLine      User1
hi! link TabLineSel   User1
hi! link TabLineFill  User1
set tabline=%!SL_Tabline()

" ----------------------}}}


" Setup commands        {{{

command! -nargs=? Tabname call AsciiStatus#KeyMapping#SetTabName(<q-args>)

" ----------------------}}}
