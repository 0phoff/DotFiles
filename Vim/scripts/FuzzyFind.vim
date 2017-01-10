" Fuzzy File finder in vanilla Vim
" This script will enable fuzzy file searching in Vim for the :find/:edit/... commands

set path=.,**           " Search down into subfolders
set wildmenu            " Display all matching files when tabbing
set completeopt=menu    " Set completion to only show popup menu & not preview scratch buffer
