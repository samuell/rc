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
" Expand a column to the left, to center the code a slight bit
nmap <C-e> :let &foldcolumn = (&columns - &textwidth) / 2<CR>
nmap <C-w> :let &foldcolumn = 0<CR>

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
" Activate plugins in ~/.vim/bundle (and ~/.vim/after/bundle, where vim-pyenv
" should be stored
" ---------------------------------------------------------------------------
execute pathogen#infect()
syntax on
filetype plugin indent on

" ---------------------------------------------------------------------------
" Vim-Go stuff
" ---------------------------------------------------------------------------
let g:neocomplete#enable_at_startup = 1
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)

" ---------------------------------------------------------------------------
" Configure vim-pyenv and jedi-vim to work nicely together
" ---------------------------------------------------------------------------
if jedi#init_python()
    function! s:jedi_auto_force_py_version() abort
        let major_version = pyenv#python#get_internal_major_version()
        call jedi#force_py_version(major_version)
    endfunction
    augroup vim-pyenv-custom-augroup
        autocmd! *
        autocmd User vim-pyenv-activate-post   call s:jedi_auto_force_py_version()
        autocmd User vim-pyenv-deactivate-post call s:jedi_auto_force_py_version()
    augroup END
endif
