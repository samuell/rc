let mapleader=','

" --------------------------------------------
" Powerline config
" --------------------------------------------
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2


" --------------------------------------------
" My own configs ... mostly python stuff
" --------------------------------------------
syntax on
colorscheme samllight
set showmatch
set ignorecase
set showmode
set ts=4
set sw=4 autoindent
set smartindent
set so=12
set nowrap
autocmd Filetype php setlocal ts=4 sw=4 noexpandtab
set shell=/bin/sh " Needed to get at least Go autocompletion to work
" --------------------------------------------


" --------------------------------------------
" Enable file type plugins
" --------------------------------------------
filetype plugin on
let g:pydiction_location='~/.vim/pydiction-1.2/complete-dict'
"
set number
autocmd FileType python set expandtab
autocmd FileType python runtime! autoload/pythoncomplete.vim
imap <c-space> <c-x><c-o>
:set backspace=2
" from /home/samuel/go/misc/vim/readme.txt
" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
	filetype off
	filetype plugin indent off
endif
set runtimepath+=$GOROOT/misc/vim/
filetype plugin indent on
filetype plugin on

if has("autocmd")
	autocmd FileType python set complete+=k/home/samuel/.vim/pydiction-1.2/pydiction isk+=.,(
	autocmd FileType go autocmd BufWritePre <buffer> Fmt
endif " has("autocmd")

filetype plugin on
filetype indent on
" --------------------------------------------


" --------------------------------------------
" Mappings
" --------------------------------------------
nmap <C-N> :noh <CR>
set hlsearch
imap jj <Esc>
" remap Ctrl + Z to save, in all modes
noremap <silent> <C-Z>      :update<CR>
vnoremap <silent> <C-Z>     :<C-C>:update<CR>
inoremap <silent> <C-Z>     <C-[>:update<CR>
" --------------------------------------------


" --------------------------------------------
" Speed up navigation 4x by holding Ctrl key
nmap <c-j> 4j
nmap <c-k> 4k
nmap <c-h> 4h
nmap <c-l> 4l
" --------------------------------------------

" --------------------------------------------
" Distraction free editing in vim
let g:goyo_width = 80
let g:goyo_margin_top = 0
let g:goyo_margin_bottom = 0
let g:goyo_linenr = 0
" --------------------------------------------
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!
"
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_trigger = 2

source ~/.vimrc_vundle
