" -------------------------------------------------------------------------------------------------------------------------------------------------------------
"    _______  __   __  _______  _______  __   __  _______  _______  ______    ___   _______  _______  _______ 
"   |       ||  | |  ||       ||       ||  | |  ||       ||       ||    _ |  |   | |       ||       ||       |
"   |    ___||  | |  ||____   ||____   ||  |_|  ||  _____||       ||   | ||  |   | |    _  ||_     _||  _____|
"   |   |___ |  |_|  | ____|  | ____|  ||       || |_____ |       ||   |_||_ |   | |   |_| |  |   |  | |_____ 
"   |    ___||       || ______|| ______||_     _||_____  ||      _||    __  ||   | |    ___|  |   |  |_____  |
"   |   |    |       || |_____ | |_____   |   |   _____| ||     |_ |   |  | ||   | |   |      |   |   _____| |
"   |___|    |_______||_______||_______|  |___|  |_______||_______||___|  |_||___| |___|      |___|  |_______|
"                                                                                                                                                              
" -------------------------------------------------------------------------------------------------------------------------------------------------------------
"
"  FuzzyScripts : FZF add-ons
"  By 0phoff
"  Version 1.0
"
" ---------------------------------------------------------------------------------------------------------------

" Settings {{{

let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'
let g:fzf_layout = { 'window': 'call FloatingWindow()' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

" }}}


" Helper Functions {{{

function! FloatingWindow(...)
  let width = float2nr(get(a:, 1, &columns * 0.9))
  let height = float2nr(get(a:, 2, &lines * 0.6))
  let opts = {
    \ 'relative': 'editor',
    \ 'row': (&lines - height) / 2,
    \ 'col': (&columns - width) / 2,
    \ 'width': width,
    \ 'height': height
    \ }

  let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')

  setlocal
    \ buftype=nofile
    \ nobuflisted
    \ bufhidden=hide
    \ nonumber
    \ norelativenumber
    \ signcolumn=no
endfunction

function! s:RipGrep(fullscreen)
  let text = input('GREP: ')

  if text != ''
    call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --smart-case --follow --hidden --iglob !.git/* --color=always ' . text,
      \ 1,
      \ {'options':  '--ansi --multi --bind=ctrl-s:select-all,ctrl-d:deselect-all'},
      \ a:fullscreen
      \ )
  endif
endfunction

function! s:GitStatusHandler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({
    \   'ctrl-a': '!git add ',
    \   'ctrl-r': '!git reset -- ',
    \ },
    \ a:lines[0], '!git add '
    \ )
  let files = join(map(a:lines[1:], {idx, val -> split(val)[1]}))

  silent execute cmd . files
  call jobstart(['bash', '-c', 'eval $(tmux display -p "\#{GITMUX_SCRIPT}")'])
endfunction

function! s:GitCommit()
  let text = input('MESSAGE: ')

  if text != ''
    silent execute "!git commit -m '" . text . "'"
    if v:shell_error
      echo 'Could not commit [' . v:shell_error . ']'
    endif
  call jobstart(['bash', '-c', 'eval $(tmux display -p "\#{GITMUX_SCRIPT}")'])
  endif
endfunction

" }}}


" Commands {{{

command! -bang  FZSRg
  \ call <SID>RipGrep(<bang>0)

command! -bang  FZSGitStatus
  \ call fzf#vim#gitfiles(
  \ '?',
  \ {
  \   'sink*':    function('<SID>GitStatusHandler'),
  \   'options':  '--ansi --expect=ctrl-a,ctrl-r --multi --bind=ctrl-s:select-all,ctrl-d:deselect-all'
  \ },
  \ <bang>0
  \ )

command!        FZSGitCommit
  \ call <SID>GitCommit()

" }}}
