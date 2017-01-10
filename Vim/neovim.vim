" ---------------------------------------------------------------------------------------------------------------
"    _           _                                             _           _      _  _  _      _           _     
"   (_) _       (_)                                           (_)         (_)    (_)(_)(_)    (_) _     _ (_)    
"   (_)(_)_     (_)       _  _  _  _           _  _  _        (_)         (_)       (_)       (_)(_)   (_)(_)    
"   (_)  (_)_   (_)      (_)(_)(_)(_)_      _ (_)(_)(_) _     (_)_       _(_)       (_)       (_) (_)_(_) (_)    
"   (_)    (_)_ (_)     (_) _  _  _ (_)    (_)         (_)      (_)     (_)         (_)       (_)   (_)   (_)    
"   (_)      (_)(_)     (_)(_)(_)(_)(_)    (_)         (_)       (_)   (_)          (_)       (_)         (_)    
"   (_)         (_)     (_)_  _  _  _      (_) _  _  _ (_)        (_)_(_)         _ (_) _     (_)         (_)    
"   (_)         (_)       (_)(_)(_)(_)        (_)(_)(_)             (_)          (_)(_)(_)    (_)         (_)    
"                                                                                                                
" ---------------------------------------------------------------------------------------------------------------
"
"  Neovim config file
"  By 0phoff
"  Version 2.2
"
" ---------------------------------------------------------------------------------------------------------------

" Plugins               {{{

let emmetFiles = ["html","xhtml","xml","xaml","xsd","xsl","css","less","scss","sass","styl","svg"]

" Internal Plugins
filetype plugin indent on                           " filetype plugin

" External Plugins
call plug#begin()
    Plug 'christoomey/vim-tmux-navigator'           " Use ctrl-hjkl to navigate vim & tmux
    Plug 'Yggdroot/indentLine'                      " Indentation lines
    Plug 'fntlnz/atags.vim'                         " Async Ctags generation
    Plug 'itchyny/lightline.vim'                    " Lightweight and customizable statusline
    Plug 'morhetz/gruvbox'                          " Awesome Colortheme
    Plug 'shinchu/lightline-gruvbox.vim'            " Colortheme for lightline
    Plug 'ryanoasis/vim-devicons'                   " Pretty File Icons

    Plug 'mattn/emmet-vim', {'for': emmetFiles}                                     " Emmet fast html-tag creation
    Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}                            " Project tree viewer
    Plug 'Shougo/Denite.nvim', {'on': 'Denite', 'do': ':UpdateRemotePlugins' }      " Project Fuzzy Finder
    autocmd! User Denite.nvim call s:DeniteMappings()
call plug#end()

" Custom Plugins
for scriptfile in split(globpath("~/.config/nvim/scripts", "*.vim"), '\n')
    execute('source '.scriptfile)
endfor

" ----------------------}}}


" Plugin Settings       {{{

" Gruvbox
set bg=dark
colorscheme gruvbox

" Atags
" TODO

" NerdTree
nnoremap <silent> <Leader>t :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMapOpenSplit = 'h'
let g:NERDTreeMapOpenVSplit = 'v'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeHighlightFolders = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''

" Denite
nnoremap <silent> <Leader>f :Denite -auto-resize -no-statusline -cursor-wrap file_rec<CR>
nnoremap <silent> <Leader>g :Denite -auto-resize -no-statusline -cursor-wrap grep<CR>
highlight! link deniteMatchedChar CursorLineNr
highlight! link deniteMatched Identifier
augroup Denite
    autocmd!
    autocmd BufEnter,BufWinEnter \[denite\]* :call s:DeniteEnter()
    autocmd BufLeave \[denite\]* :call s:DeniteLeave()
augroup END
    function! s:DeniteEnter()   "{{{
        highlight! CursorLine ctermbg=237
    endfunction                 "}}}
    function! s:DeniteLeave()   "{{{
        highlight! CursorLine NONE
    endfunction                 "}}}
    function! s:DeniteMappings()    "{{{
        call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>'      , 'noremap')
        call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>'  , 'noremap')
        call denite#custom#map('insert', '<C-e>', '<denite:do_action:switch>'       , 'noremap')
        call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabswitch>'    , 'noremap')
        call denite#custom#map('insert', '<C-h>', '<denite:do_action:splitswitch>'  , 'noremap')
        call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplitswitch>' , 'noremap')
        call denite#custom#map('insert', 'jj'   , '<denite:enter_mode:normal>'      , 'noremap')
        call denite#custom#map('insert', 'ZZ'   , '<denite:quit>'                   , 'noremap')
        
        call denite#custom#map('normal', 'n'    , '<denite:move_to_next_line>'      , 'noremap')
        call denite#custom#map('normal', 'p'    , '<denite:move_to_previous_line>'  , 'noremap')
        call denite#custom#map('normal', 'e'    , '<denite:do_action:switch>'       , 'noremap')
        call denite#custom#map('normal', 't'    , '<denite:do_action:tabswitch>'    , 'noremap')
        call denite#custom#map('normal', 'h'    , '<denite:do_action:splitswitch>'  , 'noremap')
        call denite#custom#map('normal', 'v'    , '<denite:do_action:vsplitswitch>' , 'noremap')
        call denite#custom#map('normal', 'ZZ'   , '<denite:quit>'                   , 'noremap')
    endfunction                     "}}}

" Lightline
set laststatus=2        " Always show statusbar
set noshowmode          " Dont show mode -> already in lightline
let g:lightline = {
    \ 'colorscheme' : 'gruvbox',
    \ 'active': {
    \   'left':     [ ['mode', 'paste'],
    \                 ['filenameMod'] ],
    \   'right':    [ ['linenumber'],
    \                 [''],
    \                 ['filetype', 'projectPath', 'rootDir'] ]
    \ },
    \ 'component_expand': {
    \   'filenameMod': 'LLfilenameMod'
    \ },
    \ 'component_function': {
    \   'projectPath': "LLpath",
    \   'rootDir': "LLroot",
    \   'linenumber': "LLline"
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }
    function! LLfilenameMod()   "{{{
        return ColDevicons_ColoredLLText('', WebDevIconsGetFileTypeSymbol(), LLfile())
    endfunction                 "}}}
    function! LLfile()          "{{{
        if &filetype ==# 'nerdtree' || &filetype ==# '[denite]'
            return ''
        else
            return ('' != expand('%:t') ? expand('%:t').LLtype() : '[No Name]')
        endif
    endfunction                 "}}}
    function! LLpath()          "{{{
        let pwd = getcwd()
        let fileDir = expand('%:p:h')
        let i = match(fileDir, pwd)
    
        if winwidth(0) > 95
            if (i == -1)
                return fileDir
            elseif (len(pwd) == len(fileDir))
                return ''
            else
                return '.' . fileDir[i+len(pwd):]
            endif
        else
            return ''
        endif
    endfunction                 "}}}
    function! LLroot()          "{{{
        if winwidth(0) > 95
            return split(getcwd(), '/')[-1]
        else
            return ''
        endif
    endfunction                 "}}}
    function! LLline()          "{{{
        return line(".") . ''
    endfunction                 "}}}
    function! LLtype()          "{{{
        if &readonly || !&modifiable
            return ' '
        elseif &modified
            return ' +'
        else
            return ''
        endif
    endfunction                 "}}}

" Colored Devicons
let g:coldevicons_filetypes = 'nerdtree,denite'

" ----------------------}}}


" Key Remapping         {{{

" Basics
    map <SPACE> <leader>
    inoremap jj <ESC>
    nnoremap <Leader><Space> za
    nnoremap <silent> <Leader>h :nohlsearch <CR>

    " JK move through line wraps in stead of real lines (except when X[j,k] is used)
    nnoremap <expr> j v:count ? 'j':'gj' 
    nnoremap <expr> k v:count ? 'k':'gk'
    vnoremap <expr> j v:count ? 'j':'gj' 
    vnoremap <expr> k v:count ? 'k':'gk'
    onoremap <expr> j v:count ? 'j':'gj' 
    onoremap <expr> k v:count ? 'k':'gk'

    " Alt-jk move through tabs
    nnoremap <M-j> gt
    nnoremap <M-k> gT

    " Search visual selection
    vnoremap // y/<C-r>"<CR>
    " Visual select last inserted text
    nnoremap gV `[v`]

    " File Manipulations
    nnoremap <silent> <Leader>w :w<CR>
    nnoremap <silent> <Leader>x :tabclose<CR>
    nnoremap <silent> <Leader>q :qa<CR>

    " Delete with X -> black hole register
    nnoremap x "_x
    vnoremap x "_x


" Function keybinds
    inoremap <silent><expr><BS> BS()
        function! BS()    "{{{
            let val = CP_RemoveEmptyPair()
            if val ==# ""
                return "\<BS>"
            else
                return val
            endif
        endfunction         "}}}
    
    inoremap <silent><expr> <CR> CR()
        function! CR()    "{{{
            let val = CP_IndentInsideCurlyBracket()
            if pumvisible()
                return "\<C-y>"
            elseif val ==# ""
                return "\<CR>"
            else
                return val
            endif
        endfunction         "}}}

    inoremap <silent> <C-a> <C-r>=CP_JumpOutPair()<CR>

    imap <silent><expr> <C-e> Ctrle()
        function! Ctrle() "{{{
            if neosnippet#expandable_or_jumpable()
                return "\<plug>(neosnippet_expand_or_jump)"
            elseif emmet#isExpandable()
                return "\<plug>(emmet-expand-abbr)"
            endif
        endfunction         "}}}

" ----------------------}}}


" Custom Settings       {{{

" TEMPORARY
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1                         " Change Cursor Shape Depending on Mode -> syntax will change in future
"autocmd VimLeave * call system('printf "\e[3 q" > $(tty)')  " Reset cursor shape to underscore in Terminal -> Doesnt work

" Highlight current line number of current buffer
hi CursorLine NONE
hi CursorLineNR cterm=bold ctermbg=NONE guibg=NONE

" Basics
set history=250             " Increase history
set encoding=utf-8          " Set encoding
set spelllang=en            " Set default spelllang

set nu                      " Set linenumbers
set rnu                     " Relative numbers
set cul                     " Highlight current line
set showcmd                 " Show command
set conceallevel=0          " Don't hide text
set linebreak               " Only wrap at whitespace
set tw=2147483647           " Don't auto wrap long lines (big Number for ftplugin)

set ignorecase              " Searching is case insensitive
set smartcase               " Searching is case sensitive if there is a capital
set incsearch               " Set incremetal searching
set hlsearch                " Highlight search

set splitbelow              " Split below current
set splitright              " Split right of current

set ttimeoutlen=3           " Fix slow mode switching
set timeoutlen=750          " 750ms for keystroke combo's

set mouse=n                 " Enable mouse in normal mode

set foldenable              " Enable folding
set foldlevelstart=99       " Open all folds when opening a file
set foldnestmax=10          " Maximum nested folds
set foldmethod=marker       " Create folds based on markers in code
set foldmarker={,}          " Markers are { }
set foldtext=IndFoldTxt()   " Indent Fold Text
    function! IndFoldTxt()    "{{{
        let indent = repeat(' ', indent(v:foldstart))
        let txt = foldtext()
        return indent.txt
    endfunction             "}}}

set tabstop=4               " Tabs are 4 characters long
set softtabstop=-1          " when entering tab -> #shiftwidth spaces are inserted
set shiftwidth=4
set expandtab               " Expand tab to spaces
set autoindent              " Auto indent code

" ----------------------}}}


" Command Groups        {{{

autocmd VimEnter * call ColDevicons_init()

" Insert Mode enter/leave
augroup InserModeCmds
    autocmd!
    autocmd InsertEnter * :call s:IEnter()
    autocmd InsertLeave,WinLeave * :call s:ILeave()
augroup END

function! s:IEnter()
    let b:last_tol=&timeoutlen
    setlocal timeoutlen=200
endfunction

function! s:ILeave()
    if exists('b:last_tol')
        let &l:timeoutlen=b:last_tol
    endif
endfunction

" ----------------------}}}
