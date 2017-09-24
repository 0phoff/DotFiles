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
"  Version 2.3
"
" ---------------------------------------------------------------------------------------------------------------

" Plugins               {{{

let emmetFiles = ["html","xhtml","xml","xaml","xsd","xsl","css","less","scss","sass","styl","svg"]

" Internal Plugins

call plug#begin()
    " Syntax Plugins
    Plug 'octol/vim-cpp-enhanced-highlight'                         " C++ 11/14/17
    Plug 'petRUShka/vim-opencl'                                     " OpenCL
    Plug 'othree/html5.vim', {'for': 'html'}                        " Html 5
    Plug 'JulesWang/css.vim', {'for': ['css','styl','scss','less']} " Css
    Plug 'wavded/vim-stylus', {'for': 'styl'}                       " Stylus
    Plug 'pangloss/vim-javascript', {'for': 'javascript'}           " Js
    Plug 'elzr/vim-json',{'for': 'json'}                            " Json
    Plug 'stephpy/vim-yaml', {'for': 'yaml'}                        " Yaml
    Plug 'kurayama/systemd-vim-syntax'                              " Systemd
    Plug 'keith/tmux.vim'                                           " Tmux
    Plug 'gabrielelana/vim-markdown'                                " Markdown
    "Plug 'fatih/vim-go'                                             " GO

    " Functional Plugins
    Plug 'scrooloose/nerdtree'                                      " Project tree viewer
    Plug 'Shougo/Denite.nvim', {'do': ':UpdateRemotePlugins' }      " Project Fuzzy Finder
    Plug 'christoomey/vim-tmux-navigator'                           " Use ctrl-hjkl to navigate vim & tmux
    Plug 'mattn/emmet-vim', {'for': emmetFiles}                     " Emmet fast html-tag creation
    Plug 'neomake/neomake'                                          " Async task running

    " Visual Plugins
    Plug 'itchyny/lightline.vim'                                    " Lightweight and customizable statusline
    Plug 'shinchu/lightline-gruvbox.vim'                            " Colortheme for lightline
    Plug 'ryanoasis/vim-devicons'                                   " Fancy Icons

    " Themes
    Plug 'morhetz/gruvbox'
    Plug 'arcticicestudio/nord-vim'

    " Custom Plugins
    Plug '~/.config/nvim/scripts/ClosePair'
    Plug '~/.config/nvim/scripts/ColDevicons'
call plug#end()

" ----------------------}}}


" Plugin Settings       {{{

" Json
let g:vim_json_syntax_conceal = 0

" Gruvbox
set bg=dark
"set termguicolors
let g:gruvbox_italic=1
let g:nord_italic_comments=1
colorscheme nord

" NerdTree
nnoremap <silent> <Leader>t :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMapOpenSplit = 'h'
let g:NERDTreeMapOpenVSplit = 'v'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeHighlightFolders = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
highlight! link NERDTreeDir Identifier
highlight! link NERDTreeOpenable NonText
highlight! link NERDTreeClosable NonText
highlight! link NERDTreeExecFile Normal

" Denite
call denite#custom#source('_', 'converters', ['devicons_denite_converter'])

call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '--ignore=*.jpg', '--ignore=*.png', '--ignore=*.bmp', '--ignore=*.gif', '--ignore=*.webp', '--ignore=*.pdf', '--ignore=*.eps', '--ignore=*.svg', '--ignore=*.mp4', '--ignore=*.avi', '--ignore=*.mov', '--ignore=*.mkv', '--ignore=*.webm', '-g', ''])
call denite#custom#alias('source', 'file_all', 'file_rec')
  call denite#custom#var('file_all', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-u', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'default_opts', ['-S', '--line-numbers', '--follow', '--nocolor', '--nogroup'])
  call denite#custom#source('grep', 'converters', [])
call denite#custom#alias('source', 'grep_all', 'grep')
  call denite#custom#var('grep_all', 'command', ['ag'])
  call denite#custom#var('grep_all', 'default_opts', ['-S', '--line-numbers', '--follow', '--nocolor', '--nogroup', '-u'])
	call denite#custom#var('grep,grep_all', 'recursive_opts', [])
	call denite#custom#var('grep,grep_all', 'pattern_opt', [])
	call denite#custom#var('grep,grep_all', 'separator', ['--'])
	call denite#custom#var('grep,grep_all', 'final_opts', [])
  call denite#custom#source('grep_all', 'converters', [])

nnoremap <silent> <Leader>ff  :Denite -auto-resize -no-statusline -cursor-wrap file_rec<CR>
nnoremap <silent> <Leader>faf :Denite -auto-resize -no-statusline -cursor-wrap file_all<CR>
nnoremap <silent> <Leader>fg  :Denite -auto-resize -no-statusline -cursor-wrap -no-empty grep<CR>
nnoremap <silent> <Leader>fag :Denite -auto-resize -no-statusline -cursor-wrap -no-empty grep_all<CR>
nnoremap <silent> <Leader>fd  :Denite -auto-resize -no-statusline -cursor-wrap directory_rec<CR>
highlight! link deniteMatchedChar Directory
highlight! link deniteMatchedRange Normal

call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>'      , 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>'  , 'noremap')
call denite#custom#map('insert', '<C-e>', '<denite:do_action:switch>'       , 'noremap')
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabswitch>'    , 'noremap')
call denite#custom#map('insert', '<C-h>', '<denite:do_action:splitswitch>'  , 'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplitswitch>' , 'noremap')
call denite#custom#map('insert', 'jj'   , '<denite:enter_mode:normal>'      , 'noremap')
call denite#custom#map('insert', 'ZZ'   , '<denite:quit>'                   , 'noremap')
call denite#custom#map('normal', 'ZZ'   , '<denite:quit>'                   , 'noremap')
augroup Denite
    autocmd!
    autocmd BufEnter,BufWinEnter \[denite\]* :call s:DeniteEnter()
    autocmd BufLeave \[denite\]* :call s:DeniteLeave()
augroup END
    function! s:DeniteEnter()   "{{{
        highlight! CursorLine ctermbg=8
    endfunction                 "}}}
    function! s:DeniteLeave()   "{{{
        highlight! CursorLine NONE
    endfunction                 "}}}

" Lightline
set laststatus=2        " Always show statusbar
set noshowmode          " Dont show mode -> already in lightline
let g:lightline = {
    \ 'colorscheme' : 'nord',
    \ 'active': {
    \   'left':     [ ['mode', 'paste'],
    \                 ['filenameMod'] ],
    \   'right':    [ ['linenumber'],
    \                 [''],
    \                 ['filetype', 'projectPath', 'rootDir'] ]
    \ },
    \ 'component': {
    \   'mode': '%{&filetype!="nerdtree"?lightline#mode():""}',
    \   'filetype': '%{&filetype!="nerdtree" && expand("%:t")!="[denite]"?&filetype:""}'
    \ },
    \ 'component_visible_condition': {
    \   'mode': '(&filetype!="nerdtree")',
    \   'filetype': '(&filetype!="nerdtree" && expand("%:t")!="[denite]")'
    \ },
    \ 'component_expand': {
    \   'filenameMod': 'LLfilenameMod'
    \ },
    \ 'component_function': {
    \   'projectPath': "LLpath",
    \   'rootDir': "LLroot",
    \   'linenumber': "LLline",
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }
    function! LLfilenameMod()   "{{{
        return ColDevicons_ColoredLLText('', 'WebDevIconsGetFileTypeSymbol()', 'LLfile()')
    endfunction                 "}}}
    function! LLfile()          "{{{
        if &filetype ==? 'nerdtree'
            return 'NERD'
        elseif expand('%:t') ==? '[denite]'
            return 'DENITE'
        else
            if &readonly || !&modifiable
                let fileMod = ' '
            elseif &modified
                let fileMod = ' +'
            else
                let fileMod = ''
            endif
            return ('' != expand('%:t') ? expand('%:t') . fileMod : '[No Name]')
        endif
    endfunction                 "}}}
    function! LLpath()          "{{{
        if &filetype ==? 'nerdtree' || expand('%:t') ==? '[denite]'
            return ''
        endif
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
        if &filetype ==? 'nerdtree' || expand('%:t') ==? '[denite]'
            return ''
        endif
        if winwidth(0) > 95
            return split(getcwd(), '/')[-1]
        else
            return ''
        endif
    endfunction                 "}}}
    function! LLline()          "{{{
        return line(".") . ''
    endfunction                 "}}}

" Neomake
let g:neomake_warning_sign = {
  \ 'text': '⚠',
  \ 'texthl': 'GruvboxYellowSign',
  \ }
let g:neomake_error_sign = {
  \ 'text': '✖',
  \ 'texthl': 'GruvboxRedSign',
  \ }
let g:neomake_javascript_enabled_makers = ['xo']

" Markdown
let g:markdown_mapping_switch_status = '-'
let g:markdown_enable_spell_checking = 0

" ----------------------}}}


" Key Remapping         {{{

" Basics
    map <SPACE> <leader>
    inoremap jj <ESC>
    nnoremap <Leader><Space> za
    nnoremap <silent> <Leader>h :nohlsearch <CR>
    nnoremap <silent> <Leader>r :tabe\|tabo!\|%bd <CR>

    " Get rid of accidental Ex Mode -> Use gQ if really wanted
    nnoremap Q <nop>

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
    nnoremap <silent> QQ :q!<CR>
    nnoremap <silent> <Leader>q mx:w\|%bd\|e#<CR>`x:delmarks x<CR>

    " Delete with X -> black hole register
    nnoremap x "_x
    vnoremap x "_x

" Function keybinds
    inoremap <silent><expr> <BS> BS()
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
            let val = CP_Indent()
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
          if (match(&ft, join(g:emmetFiles, '\|')) != -1)
            if emmet#isExpandable()
                return "\<plug>(emmet-expand-abbr)"
            else
                return "\<plug>(emmet-move-next)"
            endif
          else
            echo "fail"
            return ""
          endif
        endfunction         "}}}

    inoremap <expr> <C-x> FullCompletion()
        function! FullCompletion()  "{{{
          let width = winwidth(0)
          let msg = "Completion: ^L_line ^N_infile ^K_dictionary ^T_thesaurus ^I_included ^]_tags ^F_files ^D_definitions ^V_vimcommand ^U_userdef ^O_omni s_spell"
          let len = strlen(msg)
          let x=&ruler | let y=&showcmd
          set noruler noshowcmd
          redraw
          if (width <= len)
            echo strpart(msg, 0, width-4) . "..."
          else
            echo msg
          endif
          let &ruler=x | let &showcmd=y
          return "\<C-x>"
        endfunction                 "}}}

" ----------------------}}}


" Custom Settings       {{{

" TEMPORARY
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1                         " Change Cursor Shape Depending on Mode -> syntax will change in future

" Highlight current line number of current buffer
hi CursorLine NONE
hi CursorLineNR cterm=bold ctermbg=NONE guibg=NONE

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

set tabstop=2               " Tabs are 4 characters long
set softtabstop=-1          " when entering tab -> #shiftwidth spaces are inserted
set shiftwidth=2
set expandtab               " Expand tab to spaces
set autoindent              " Auto indent code

set path=.,**               " Search down into subfolders
set wildmenu                " Display all matching files when tabbing
set completeopt=menu        " Set completion to only show popup menu & not preview scratch buffer

" ----------------------}}}


" Command Groups        {{{

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

" Gitmux Update variables on save
autocmd BufWritePost * silent! jobstart(['bash', '-c', 'eval $(tmux display -p "\#{GITMUX_SCRIPT}")'])

" ----------------------}}}

