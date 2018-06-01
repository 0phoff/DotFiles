" Shell Settings
if exists('b:did_ftplugin_pers') | finish | endif

" tab = 4spaces, expandtabs
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

" Settings loaded buffer flag
let b:did_ftplugin_pers = 1
