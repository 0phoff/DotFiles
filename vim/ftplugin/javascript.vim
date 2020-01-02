" Javascript Settings
if exists('b:did_ftplugin_pers') | finish | endif

" Add ` to pairs
if !exists('b:CP_Pairs')
  let b:CP_Pairs = []
  call CP_UpdatePairs(g:CP_PairsDefault)
endif
call CP_AddPair('`', '`')

" Settings loaded buffer flag
let b:did_ftplugin_pers = 1
