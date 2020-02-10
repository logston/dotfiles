" === START vim-plug
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'chiel92/vim-autoformat'
Plug 'davidhalter/jedi-vim'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'editorconfig/editorconfig-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" https://bolt80.com/gutentags/
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'Valloric/YouCompleteMe'
Plug 'victorze/foo'
Plug 'vim-scripts/indentpython.vim'
Plug 'w0rp/ale'

" Initialize plugin system
call plug#end()

" === GENERAL ===
" \s for saving files
set hidden  " Allow buffer switching without saving
set backspace=eol,start,indent       " set backspace
set cursorline cursorcolumn          " show a visual line under the cursor's current line
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set nowrap        " display long lines as just one line
set number        " show line numbers set showcmd
set showmatch     " show the matching part of the pair for [] {} and ()
set wildmenu      " used for command line completion
set scrolloff=5   " determines the number of context lines you would like to see above and below the cursor
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir
set fileformat=unix

" Spelling
set spell
set spellfile=$HOME/.vim/spell/en.utf-8.add
set spelllang=en
set encoding=utf-8

" Status line and lightline
set laststatus=2  " display the status line always
set noshowmode  " don't display -- INSERT -- in lower area. Obsolete due to light line
let g:lightline = {
\   'colorscheme': 'wombat',
\   'active': {
\     'left': [
\         ['mode', 'paste'],
\         ['readonly', 'filename', 'modified']
\     ],
\     'right': [
\         ['lineinfo'],
\         ['percent'],
\         ['op', 'fileformat', 'fileencoding', 'filetype']
\     ]
\   },
\   'component_function': {
\      'filename': 'LightLineFilename',
\      'op': 'GutentagsStatus',
\   },
\ }

function! LightLineFilename()
    return expand('%:f')
endfunction

" === MAPPINGS ===
" Navigation
noremap <Up>     <NOP>
noremap <Down>   <NOP>
noremap <Left>   <NOP>
noremap <Right>  <NOP>
" buffer control
noremap <C-k>    :bp<CR>
noremap <C-l>    :bn<CR>
noremap <C-8>    :bd<CR>
noremap <C-w>    <C-w>w

" === SEARCH ===
set hlsearch  " highlight search
set incsearch " incrementally highlight as search takes place
" File search
nnoremap <C-f> :GFiles<CR>
" String search
nnoremap <C-h> :Rg<CR>
noremap  <C-g> :exec 'Rg' expand('<cword>')<CR>
" Tag search
nnoremap <C-p> :TagbarToggle<CR>

" ctags
" To know when Gutentags is generating tags
function! GutentagsStatus()
    return gutentags#statusline()
endfunction
let g:gutentags_ctags_tagfile = '.ctags-index'

" YCM
" Pull from keywords in the current file, other buffers (closed or still
" open), and from the current tags file.
set complete=.,b,u,]
let g:ycm_autoclose_preview_window_after_completion=1

" === LANGUAGE SPECIFICS ===
syntax on
syntax enable     " enable syntax highlighting

" === TABS AND SPACES ====
" Continue indentation of the current line to the next
set autoindent
" Indent according to the code you are editing
set smartindent
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert spaces
set expandtab
"set smarttab
" Default softtabstop to tabstop
set softtabstop=0

"ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" --- Highlights ---
highlight OverLength ctermbg=LightRed
" Set so Vim Jedi uses reasonable colors for Pmenu/PmenuSel. Requires a
" 'github' colorscheme. Installed 'github' from 'victorze/foo'.
let g:colors_name = 'github'


" --- GIT ---
au FileType gitcommit setlocal spell
au Filetype gitcommit set textwidth=72
au Filetype gitcommit set ruler

" --- PYTHON ---
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set shiftwidth=4 |
    \ set colorcolumn=101 |
    \ match OverLength /\%101v.\+/
let g:pymode_python = 'python3'

" let b:ale_fix_on_save = 1
let b:ale_fixers = ['black', 'isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']

" frontend
au BufNewFile,BufRead *.js,*.jsx,*.html,*.css
    \ set tabstop=2 |
    \ set shiftwidth=2

" --- Generic Helper Functions ---
au BufEnter * call CloseQuickfix()
function! CloseQuickfix()
  " if the window is quickfix go on
  if &buftype == "quickfix"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction

" === FINAL VIMRC TASKS ===
" allows for per-project configuration files
set exrc
" disable unsafe commands in your project-specific .vimrc files
set secure
