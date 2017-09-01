" Javascript Settings
if exists('b:did_afterftplugin') | finish | endif

" Add ` to pairs
if !exists('b:CP_Pairs')
  let b:CP_Pairs = []
  call CP_UpdatePairs(g:CP_PairsDefault)
endif
call CP_AddPair('`', '`')

" Automatically run XO
autocmd! BufReadPost,BufWritePost *.js Neomake

" Settings loaded buffer flag
let b:did_afterftplugin = 1
