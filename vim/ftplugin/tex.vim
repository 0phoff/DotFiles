" LaTeX Settings
if exists('b:did_ftplugin_pers') | finish | endif

let g:tex_conceal = "" 

" Random Settings
setlocal foldmethod=syntax
setlocal lazyredraw
setlocal nornu
setlocal conceallevel=0

" tab = 2spaces, keep tabs
setlocal shiftwidth=2
setlocal tabstop=2
setlocal noexpandtab

" Settings loaded buffer flag
let b:did_ftplugin_pers = 1
