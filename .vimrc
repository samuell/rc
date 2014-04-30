" --------------------------------------------
" Powerline config
" --------------------------------------------
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2


" --------------------------------------------
" My own configs ... mostly python stuff
" --------------------------------------------
syntax on
colorscheme saml
set showmatch
set ignorecase
set showmode
set ts=4
set sw=4
set autoindent
set smartindent
set so=999
" --------------------------------------------


" --------------------------------------------
" Enable file type plugins
" --------------------------------------------
filetype plugin on
let g:pydiction_location='~/.vim/pydiction-1.2/complete-dict'

set number
set expandtab
autocmd FileType python runtime! autoload/pythoncomplete.vim
imap <c-space> <c-x><c-o>
:set backspace=2
" from /home/samuel/go/misc/vim/readme.txt
" Some Linux distributions set filetype in /etc/vimrc. 
" Clear filetype flags before changing runtimepath to force Vim to reload them. 
filetype off 
filetype plugin indent off 
set runtimepath+=$GOROOT/misc/vim 
filetype plugin indent on 
filetype plugin on
if has("autocmd")
    autocmd FileType python set complete+=k/home/samuel/.vim/pydiction-1.2/pydiction isk+=.,(
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
"nmap <s-j> 2j
"nmap <s-k> 2k
"nmap <s-h> 2h
"nmap <s-l> 2l
nmap <c-j> 4j
nmap <c-k> 4k
nmap <c-h> 4h
nmap <c-l> 4l
" --------------------------------------------


" --------------------------------------------
" Vundle bundle manager set up
" --------------------------------------------
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
" Required! 
Bundle 'gmarik/vundle'
Bundle 'davidhalter/jedi-vim'
" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'msanders/snipmate.vim'
" --------------------------------------------

