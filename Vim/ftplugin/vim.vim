" Vimscript Settings
if exists('b:did_ftplugin_pers') | finish | endif

setlocal foldmarker={{{,}}}
setlocal foldmethod=marker
setlocal nowrap

" Settings loaded buffer flag
let b:did_ftplugin_pers = 1
