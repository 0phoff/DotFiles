" SV Settings
if exists('b:did_ftplugin_pers') | finish | endif

setlocal commentstring=#\ %s
setlocal comments=:#

setlocal nowrap
setlocal tabstop=8
setlocal shiftwidth=8
setlocal noexpandtab

" Settings loaded buffer flag
let b:did_ftplugin_pers = 1
