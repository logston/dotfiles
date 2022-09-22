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

" C/C++ syntax highlighting and formatting
"Plug 'bfrg/vim-cpp-modern'
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'rhysd/vim-clang-format'

" " Golang
" " CRL
" Plug 'irfansharif/vim-crlfmt'

Plug '~/Code/vim/paul'

" Initialize plugin system
call plug#end()

" Load CoC
source ~/.config/nvim/coc.vim
source ~/.config/nvim/coc-custom.vim

" === GENERAL ===
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
set listchars=tab:»\ ,eol:↲,nbsp:␣

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
nmap <leader>qq  :q<CR>
nmap <leader>s  :wa<CR>
nmap <leader>m  :Marks<CR>
nmap <leader>h  :History<CR>
nmap <leader>bc :BCommits<CR>
nmap <leader>w :set list<CR>
nmap <leader>W :set nolist<CR>
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

" --- Colors and Highlights
" ctermxx is used by console version of Vim (ie. when notermguicolors is set). guixx
" is used in GVim, or in console if termguicolors is set, and the console is
" capable of TrueColor.
" https://www.ditig.com/256-colors-cheat-sheet
"
" termguicolors Enables 24-bit RGB color in the |TUI|.  Uses "gui" |:highlight|
" attributes instead of "cterm" attributes. |highlight-guifg|
" Requires an ISO-8613-3 compatible terminal.
set notermguicolors " turned off, less is more

" colorscheme should set or return g:color_name (or default if g:color_name is
" empty). It is set specifically to "default" here (ie. a noop) to clear the
" slate for future color changes.
colorscheme default
" background is set to light as a safe default in the event colors load
" incorrectly.
set background=light
" Use :highlight to see current settings.
" - Built-ins
highlight OverLength                      ctermbg=203
highlight SignColumn                      ctermbg=None
highlight SpellBad            ctermfg=9   ctermbg=15
" Popup menu: selected item.
highlight PmenuSel            ctermfg=255 ctermbg=54
" Popup menu: selected item.
highlight PmenuThumb          ctermfg=255 ctermbg=54
" - Plugin Specific
highlight LspErrorHighlight               ctermbg=203
highlight LspWarningHighlight             ctermbg=229
highlight link CocMenuSel                  PmenuSel
highlight link CocUnusedHighlight          Error
highlight link FgCocHintFloatBgCocFloating Pmenu

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

" --- C/C++
" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1

" --- Golang
au BufNewFile,BufRead *.go
    \ set colorcolumn=121 |
    \ match OverLength /\%121v.\+/
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.go :Format

" --- Python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set expandtab |
    \ set shiftwidth=4 |
    \ set colorcolumn=101 |
    \ match OverLength /\%101v.\+/

" --- Java
au BufNewFile,BufRead *.java
    \ set tabstop=3 |
    \ set expandtab |
    \ set shiftwidth=3 |
    \ set colorcolumn=81 |
    \ match OverLength /\%81v.\+/

" --- Frontend
au BufNewFile,BufRead *.js,*.jsx,*.html,*.css
    \ set tabstop=2 |
    \ set shiftwidth=2

