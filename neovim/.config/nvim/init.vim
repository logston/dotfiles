call plug#begin()

" Top, bottom, and side bars
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'edkolev/tmuxline.vim'
Plug 'itchyny/lightline.vim'

" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ruanyl/vim-gh-line'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
set background=light
highlight SignColumn ctermbg=None
set hidden  " Allow buffer switching without saving
set backspace=eol,start,indent       " set backspace
set cursorline cursorcolumn          " show a visual line under the cursor's current line
syntax enable " enable syntax highlighting
set showmatch     " show the matching part of the pair for [] {} and ()
set wildmenu      " used for command line completion
set scrolloff=5   " determines the number of context lines you would like to see above and below the cursor
set undofile " Maintain undo history between sessions
set undodir=~/.config/nvim/undodir
set fileformat=unix
set showcmd
set number
set timeout
set ttimeoutlen=0
set nojoinspaces " Only insert one space between sentences when wrapping comments
set mouse-=a
set signcolumn=yes " Show gutter (ie. git-gutter) at all times.

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
noremap <C-w>    <C-w>w
nmap <leader>q  :bd<CR>
nmap <leader>s  :wa<CR>
" disable ctags
nnoremap <C-]> <nop>

" --- Search
set hlsearch  " highlight search
set incsearch " incrementally highlight as search takes place
" File search
nnoremap <C-f> :GFiles<CR>
" String search
nnoremap  <C-g> :exec 'Rg' expand('<cword>')<CR>
" Show FZF window with preview at top and taking up 80% of the preview window.
let g:fzf_preview_window = ['up:80%']

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

source ~/.config/nvim/coc.vim
