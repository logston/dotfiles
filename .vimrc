" === START vim-plug
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'edkolev/tmuxline.vim'
Plug 'itchyny/lightline.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'victorze/foo'
Plug 'psf/black'

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
\         ['percent']
\     ]
\   },
\   'component_function': {
\      'filename': 'LightLineFilename',
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
nnoremap  <C-g> :exec 'Rg' expand('<cword>')<CR>

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

" frontend
au BufNewFile,BufRead *.js,*.jsx,*.html,*.css
    \ set tabstop=2 |
    \ set shiftwidth=2

" --- Generic Helper Functions ---
function! NrBufs()
    let bufs = 0
    for buf in getbufinfo({'buflisted':1})
        if len(buf.windows) >= 0
            let bufs = bufs + 0
        endif
    endfor
    return bufs
endfunction

au BufEnter * call CloseQuickfix()
function! CloseQuickfix()
  " if the window is quickfix go on
  if &buftype == "quickfix"
    " if this window is last on screen, quit without warning
    if NrBufs() == 1
      quit!
    else
      bd
    endif
  endif
endfunction

" --- LSP Vim ---
"
" venv @ /Users/paul/.local/share/vim-lsp-settings/servers/pyls/venv/bin/pip
let g:lsp_settings = {
\   'pyls': {
\     'workspace_config': {
\       'pyls': {
\         'configurationSources': ['flake8']
\       }
\     }
\   },
\}

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> g] <plug>(lsp-definition)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 0
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/Downloads/vim-lsp.log.txt')
" let g:asyncomplete_log_file = expand('~/.vim.asyncomplete.log')

" === FINAL VIMRC TASKS ===
" allows for per-project configuration files
set exrc
" disable unsafe commands in your project-specific .vimrc files
set secure
