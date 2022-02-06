" === START vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Top, bottom, and side bars
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'edkolev/tmuxline.vim'
Plug 'itchyny/lightline.vim'

" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Multiple cursors (eg. ctrl+n)
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Comment out stuff (eg. gcc)
Plug 'tpope/vim-commentary'

" Git stuffs (eg. :Gblame)
Plug 'tpope/vim-fugitive'
" Sweet git viewing (eg. \gv). Requires fugitive.
Plug 'junegunn/gv.vim'

Plug '~/Code/vim/paul'

" Initialize plugin system
call plug#end()

" === GENERAL ===
set hidden  " Allow buffer switching without saving
set backspace=eol,start,indent       " set backspace
set cursorline cursorcolumn          " show a visual line under the cursor's current line
syntax enable " enable syntax highlighting
set showmatch     " show the matching part of the pair for [] {} and ()
set wildmenu      " used for command line completion
set scrolloff=5   " determines the number of context lines you would like to see above and below the cursor
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir
set fileformat=unix
set showcmd
set number
set timeout
set ttimeoutlen=0
set nojoinspaces " Only insert one space between sentences when wrapping comments
set mouse-=a

" --- Tabs and Spaces
" Continue indentation of the current line to the next
set autoindent
" Indent according to the code you are editing
set smartindent
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert spaces
"set smarttab
" Default softtabstop to tabstop
set softtabstop=0

" --- Spelling
set spell
set spellfile=$HOME/.vim/spell/en.utf-8.add
set spelllang=en
set encoding=utf-8

" --- Mappings
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
nmap <leader>q  :bd<CR>
" disable ctags
nnoremap <C-]> <nop>

nnoremap <Leader>w :set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣<CR>
nnoremap <Leader>W :set list!<CR>

" --- Search
set hlsearch  " highlight search
set incsearch " incrementally highlight as search takes place
" File search
nnoremap <C-f> :GFiles<CR>
" String search
nnoremap  <C-g> :exec 'Rg' expand('<cword>')<CR>

" --- Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" --- Highlights
" Try :help cterm-colors for more colors
highlight OverLength ctermbg=LightRed
highlight LspErrorHighlight ctermbg=LightRed
highlight LspWarningHighlight ctermbg=LightYellow
highlight SpellBad ctermfg=Red ctermbg=White

" --- Status line and Lightline
set laststatus=2  " display the status line always
set noshowmode  " don't display -- INSERT -- in lower area. Obsolete due to light line
let g:lightline = {
\   'colorscheme': 'wombat',
\   'active': {
\     'left': [
\         ['mode', 'paste'],
\         ['readonly', 'filename', 'method']
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

" === LANGUAGE SPECIFICS ===

" --- Git
au FileType gitcommit setlocal spell
au Filetype gitcommit set textwidth=72
au Filetype gitcommit set ruler
" Git control
nmap <leader>gv  :GV<CR>
nmap <leader>gb  :Git blame<CR>

" --- Golang
au BufNewFile,BufRead *.go
    \ set colorcolumn=121 |
    \ match OverLength /\%121v.\+/

" --- Python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set expandtab |
    \ set shiftwidth=4 |
    \ set colorcolumn=101 |
    \ match OverLength /\%101v.\+/

" --- Frontend
au BufNewFile,BufRead *.js,*.jsx,*.html,*.css
    \ set tabstop=2 |
    \ set shiftwidth=2

" --- Language Server Protocol
" Time to wait in milliseconds for language server formatting operation to
" complete.
" Without this setting, language servers like gopls will cause Vim to freeze
" when attempting to attempting to save due to blocking on LspDocumentFormatSync.
let g:lsp_format_sync_timeout = 1000

" --- Golang
if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'whitelist': ['go'],
        \ })

	" TODO: Setup go-fmt
  	autocmd FileType go setlocal omnifunc=lsp#complete
    autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
    autocmd BufWritePre *.go LspDocumentFormatSync
endif
