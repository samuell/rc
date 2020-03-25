" --------------------------------------------
" General stuff
" --------------------------------------------
let mapleader=','    " Use , as leader key
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

" Remap Ctrl + S to save, in all modes:
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
" (Commented out, as it interferes with C-X,C-O-autocompletion)
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
" Pathogen
" ---------------------------------------------------------------------------
syntax on
filetype plugin indent on
execute pathogen#infect()
