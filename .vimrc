" --------------------------------------------
" General stuff
" --------------------------------------------
let mapleader = ','    " Use , as leader key
set hlsearch         " Highlight search results
set backspace=2      " Make backspace work like most other apps

" --------------------------------------------
" Code display
" --------------------------------------------
syntax on            " Turn on syntax highlighting
colorscheme cyanic   " Set the color scheme
set nowrap           " Don't wrap text that goes outside the screen
set scrolloff=12     " Ensure to always see some lines of context
set showmatch        " Highlight matching braces
set showmode         " Show in which editing mode you currently are

" --------------------------------------------
" Code formatting
" --------------------------------------------
set ignorecase       " Ignore casing when searching
set tabstop=4        " Tell how long a hard tab is
set softtabstop=4    " How many spaces are inserted on a <TAB> press
set shiftwidth=4     " How many 'spaces' a shift move with << >> operators is
set expandtab        " Convert tabs to spaces (for Go, gofmt will take care of converting back)
set autoindent       " Just keeps the indentation of the previous line
set smartindent      " Adds an extra indentation in some cases
set shell=/bin/sh    " Needed to get at least Go autocompletion to work

" --------------------------------------------
" Code formatting
" --------------------------------------------
autocmd Filetype php setlocal noexpandtab
autocmd FileType python setlocal expandtab

" --------------------------------------------
" Mappings
" --------------------------------------------
nmap <C-N> :noh <CR>
imap jj <Esc>
" Remap Ctrl + Z to save, in all modes:
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <ESC>:update<CR>
inoremap <silent> <C-S>         <ESC>:update<CR>
" Speed up navigation 4x by holding Ctrl key
nmap <c-j> 4j
nmap <c-k> 4k
nmap <c-h> 4h
nmap <c-l> 4l

" Turn of vim's increment command
nnoremap <silent> <C-A>  <Nop>
vnoremap <silent> <C-A>  <Nop>
inoremap <silent> <C-A>  <Nop>
" Turn of vim's decrement command
"nnoremap <silent> <C-X>  <Nop>
"vnoremap <silent> <C-X>  <Nop>
"inoremap <silent> <C-X>  <Nop>

" ---------------------------------------------------------------------------
" Settings for vim wiki
" ---------------------------------------------------------------------------
set nocompatible
filetype plugin on
syntax on

" ---------------------------------------------------------------------------
" Vim plug (https://github.com/junegunn/vim-plug)
" ---------------------------------------------------------------------------

"Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugs')

" Python stuff
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' } " https://github.com/hanschen/vim-ipython-cell
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Go stuff
Plug 'fatih/vim-go', { 'for': 'go' }

" Rust stuff
Plug 'rust-lang/rust.vim'

" Rust stuff
Plug 'vim-crystal/vim-crystal'

" Initialize plugin system
call plug#end()

" ---------------------------------------------------------------------------
" Vim IPython Cell / Slime
" ---------------------------------------------------------------------------

let g:slime_target = "tmux"

let g:ipython_cell_delimit_cells_by = 'tags'
let g:ipython_cell_valid_marks = [ '#%%' ]

" map <Leader>c to execute the current cell
nnoremap <Leader>c :IPythonCellExecuteCell<CR>

" map <Leader>C to execute the current cell and jump to the next cell
nnoremap <Leader>C :IPythonCellExecuteCellJump<CR>
"
" map <Leader>a to 'run all' in the document
nnoremap <Leader>a :IPythonCellRun<CR>
"
" ---------------------------------------------------------------------------
" Vim-Crystal config
" ---------------------------------------------------------------------------

let g:crystal_auto_format = 1
