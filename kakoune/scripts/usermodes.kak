# User Mode Keys
# --------------
map global user , ': enter-user-mode shortcuts<ret>'                -docstring 'Shortcuts'


# Shortcuts
# ---------
declare-user-mode shortcuts
map global shortcuts y '<a-|> xclip -sel clip -i<ret>'                                      -docstring 'yank into the clipboard'
map global shortcuts p '<a-!> xclip -sel clip -o<ret>'                                      -docstring 'paste from the clipboard'
map global shortcuts w ': w<ret>'                                                           -docstring 'write buffer'
map global shortcuts d ': db<ret>'                                                          -docstring 'delete buffer'
map global shortcuts c ': q<ret>'                                                           -docstring 'close client'
map global shortcuts q ': require-module connect-custom<ret>: $ :quit-all<ret>'             -docstring 'quit kakoune'
map global shortcuts x ': wa<ret>: require-module connect-custom<ret>: $ :quit-all<ret>'    -docstring 'save all buffers and quit kakoune'


# Extra Goto
# ----------
map global goto n '<esc>: grep-next-match<ret>'          -docstring 'next grep'
map global goto p '<esc>: grep-previous-match<ret>'      -docstring 'previou grep'

