# User Mode Keys
# --------------
map global user , ': enter-user-mode shortcuts<ret>'                -docstring 'Shortcuts'


# Shortcuts
# ---------
declare-user-mode shortcuts
map global shortcuts y '<a-|> xclip -sel clip -i<ret>'              -docstring 'Yank into the clipboard'
map global shortcuts p '<a-!> xclip -sel clip -o<ret>'              -docstring 'Paste from the clipboard'
map global shortcuts w ': w<ret>'                                   -docstring 'Save current buffer'
map global shortcuts d ': db<ret>'                                  -docstring 'Close current buffer'
map global shortcuts q ': q<ret>'                                   -docstring 'Quit current client'
map global shortcuts x ': waq<ret>'                                 -docstring 'Save all buffers and quit'
