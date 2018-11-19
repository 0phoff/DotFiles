" ---------------------------------------------------------------------------------------------------------------
"      _   ___  ___ ___ ___    ___ _____ _ _____ _   _ ___ 
"     /_\ / __|/ __|_ _|_ _|  / __|_   _/_\_   _| | | / __|
"    / _ \\__ \ (__ | | | |   \__ \ | |/ _ \| | | |_| \__ \
"   /_/ \_\___/\___|___|___|  |___/ |_/_/ \_\_|  \___/|___/
"                                                       
" ---------------------------------------------------------------------------------------------------------------

if exists("g:AsciiStatusKeyMapping")
    finish
endif
let g:AsciiStatusKeyMapping = 1

function! AsciiStatus#KeyMapping#SetTabName(name)
  if empty(a:name)
    unlet t:tabname
  else
    let t:tabname = a:name
  endif
    
  exec "set stal=" . &showtabline
endfunction
