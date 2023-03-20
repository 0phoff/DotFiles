map global user , ': enter-user-mode shortcuts<ret>'                -docstring 'Shortcuts'

declare-user-mode shortcuts
map global shortcuts y '<a-|> xclip -i -selection clipboard<ret>'                           -docstring 'yank into the clipboard'
map global shortcuts p '<a-!> xclip -o -selection clipboard<ret>'                           -docstring 'paste from the clipboard'
map global shortcuts t ': tmux-persist-session-name<ret>'                                   -docstring 'keep tmux session name'
map global shortcuts w ': w<ret>'                                                           -docstring 'write buffer'
map global shortcuts d ': db<ret>'                                                          -docstring 'delete buffer'
map global shortcuts c ': q<ret>'                                                           -docstring 'close client'
map global shortcuts q ': require-module connect-custom<ret>: $ :quit-all<ret>'             -docstring 'quit kakoune'
map global shortcuts x ': wa<ret>: require-module connect-custom<ret>: $ :quit-all<ret>'    -docstring 'save all buffers and quit kakoune'
