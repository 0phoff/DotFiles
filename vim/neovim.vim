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

let emmetFiles  = ["html","xhtml","xml","xaml","xsd","xsl","css","less","scss","sass","styl","svg", "javascriptreact"]
let jsFiles     = ["javascript", "typescript", "javascriptreact", "typescriptreact"]

" Internal Plugins

let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin()
    " Syntax Plugins
    Plug 'yuezk/vim-js', {'for': jsFiles}                           " Better JS
    Plug 'maxmellon/vim-jsx-pretty', {'for': jsFiles}               " JSX
    Plug 'leafgarland/typescript-vim', {'for': jsFiles}             " TS/TSX
    Plug 'jxnblk/vim-mdx-js'                                        " MDX

    " Functional Plugins
    Plug 'christoomey/vim-tmux-navigator'                           " Use ctrl-hjkl to navigate vim & tmux
    Plug 'mattn/emmet-vim', {'for': emmetFiles}                     " Emmet fast html-tag creation
    Plug '~/.fzf'                                                   " Point to install path of FZF
    Plug 'junegunn/fzf.vim'                                         " Fuzzy finder in vim

    " Visual Plugins
    Plug 'arcticicestudio/nord-vim'                                 " Nord theme

    " Custom Plugins
    Plug '~/.config/nvim/scripts/ClosePair'
    Plug '~/.config/nvim/scripts/AsciiStatus'
    Plug '~/.config/nvim/scripts/FuzzyScripts'
    Plug '~/.config/nvim/scripts/RelativeFileCompletion/'
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

" Emmet
let g:user_emmet_settings = {
\  "javascriptreact" : {
\      "extends" : "jsx",
\  },
\}


" ----------------------}}}


" Custom Settings       {{{

" Highlight current line number of current buffer
hi CursorLine NONE
hi CursorLineNR cterm=bold ctermbg=NONE guibg=NONE
hi Visual ctermbg=3
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

set history=250             " Increase history
set dir=/tmp                " Set swapfile directory to /tmp
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
set completefunc=RelativeFileCompletion#completefunc

set exrc                    " Allow project-specific local rc files
set secure                  " Secure project specific rc files

let g:python_host_prog='/usr/bin/python'

" ----------------------}}}


" Key Remapping         {{{

  " Basics
    map <SPACE> <leader>
    inoremap jj <ESC>
    nnoremap <Leader><Space> za
    nnoremap <silent> <Leader>w :w <CR>
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

    " Files
    nnoremap <silent> <Leader>ff :Files <CR>
    nnoremap <silent> <Leader>fg :FZSRg <CR>

    " Buffer mappings
    nnoremap <M-j> :bn <CR>
    nnoremap <M-k> :bp <CR>
    nnoremap <Leader>bb :FZSBuffers <CR>
    nnoremap <Leader>bd :tabe\|tabo!\|%bd<CR>
    nnoremap <silent> <Leader>bh :b# <CR>
    nnoremap <silent> <Leader>c :bd<CR>

    " Git maps
    nnoremap <silent> <Leader>gf :FZSGitStatus <CR>
    nnoremap <silent> <Leader>gc :FZSGitCommit <CR>

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
        let msg = "Completion: L line | N infile | F files | U localfiles | I included | ] tags | K dictionary | T thesaurus | D definitions | V vimcommand | O omni | s spell"
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
