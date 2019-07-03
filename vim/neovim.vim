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
"  Version 3.0
"
" ---------------------------------------------------------------------------------------------------------------

" Plugins               {{{

let emmetFiles = ["html","xhtml","xml","xaml","xsd","xsl","css","less","scss","sass","styl","svg"]

" Internal Plugins

call plug#begin()
    " Syntax Plugins
    "Plug 'othree/html5.vim', {'for': 'html'}                        " Html 5
    "Plug 'JulesWang/css.vim', {'for': ['css','styl','scss','less']} " Css
    "Plug 'wavded/vim-stylus', {'for': 'styl'}                       " Stylus
    "Plug 'pangloss/vim-javascript', {'for': 'javascript'}           " Js
    "Plug 'elzr/vim-json',{'for': 'json'}                            " Json
    "Plug 'stephpy/vim-yaml', {'for': 'yaml'}                        " Yaml
    "Plug 'keith/tmux.vim'                                           " Tmux
    "Plug 'gabrielelana/vim-markdown'                                " Markdown

    " Functional Plugins
    Plug 'christoomey/vim-tmux-navigator'                           " Use ctrl-hjkl to navigate vim & tmux
    Plug 'mattn/emmet-vim', {'for': emmetFiles}                     " Emmet fast html-tag creation

    " Visual Plugins
    Plug 'arcticicestudio/nord-vim'                                 " Nord theme

    " Custom Plugins
    Plug '~/.config/nvim/scripts/ClosePair'
    Plug '~/.config/nvim/scripts/AsciiStatus'
call plug#end()

" ----------------------}}}


" Plugin Settings       {{{

" Theme
set bg=dark
let g:nord_italic_comments=1
colorscheme nord

" Statusline
set laststatus=2        " Always show statusbar
set noshowmode          " Dont show mode -> already in statusline

" ----------------------}}}


" Key Remapping         {{{

  " Basics
    map <SPACE> <leader>
    inoremap jj <ESC>
    nnoremap <Leader><Space> za
    nnoremap <silent> <Leader>w :w<CR>
    nnoremap <silent> <Leader>h :nohlsearch <CR>
    nnoremap <silent> <Leader>s :syntax sync fromstart <CR>

    " Get rid of accidental Ex Mode -> Use gQ if really wanted
    nnoremap Q <nop>

    " JK move through line wraps in stead of real lines (except when X[j,k] is used)
    nnoremap <silent> <expr> j v:count ? 'j':'gj' 
    nnoremap <silent> <expr> k v:count ? 'k':'gk'
    vnoremap <silent> <expr> j v:count ? 'j':'gj' 
    vnoremap <silent> <expr> k v:count ? 'k':'gk'
    onoremap <silent> <expr> j v:count ? 'j':'gj' 
    onoremap <silent> <expr> k v:count ? 'k':'gk'

    " Buffer mappings
    nnoremap <M-j> :bn <CR>
    nnoremap <M-k> :bp <CR>
    nnoremap <silent> <Leader>bh :b# <CR>
    nnoremap <Leader>bb :ls<CR>:b
    nnoremap <Leader>bd :tabe\|tabo!\|%bd<CR>
    nnoremap <silent> <Leader>q :bd<CR>

    " Search visual selection
    vnoremap // y/<C-r>"<CR>
    " Visual select last inserted text
    nnoremap gV `[v`]

    " Delete with X -> black hole register
    nnoremap x "_x
    vnoremap x "_x

" Function keybinds
    inoremap <silent><expr> <BS> BS()
      function! BS()              "{{{
        let val = CP_RemoveEmptyPair()
          if val ==# ""
            return "\<BS>"
          else
            return val
          endif
      endfunction                 "}}}
    
    inoremap <silent><expr> <CR> CR()
      function! CR()              "{{{
        let val = CP_Indent()
        if pumvisible()
          return "\<C-y>"
        elseif val ==# ""
          return "\<CR>"
        else
          return val
        endif
      endfunction                 "}}}

    inoremap <silent> <C-a> <C-r>=CP_JumpOutPair()<CR>

    imap <silent><expr> <C-e> Ctrle()
      function! Ctrle()           "{{{
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
      endfunction                 "}}}

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
hi Visual ctermbg=3

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

set hidden                  " Allow to leave unsaved buffers
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
    return indent . txt
  endfunction               "}}}

set tabstop=2               " Tabs are 2 characters long
set softtabstop=-1          " when entering tab -> #shiftwidth spaces are inserted
set shiftwidth=2
set expandtab               " Expand tab to spaces
set autoindent              " Auto indent code

set path=.,**               " Search down into subfolders
set wildmenu                " Display all matching files when tabbing
set completeopt=menu        " Set completion to only show popup menu & not preview scratch buffer

set exrc                    " Allow project-specific local rc files
set secure                  " Secure project specific rc files

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
