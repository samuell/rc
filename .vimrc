syntax on
colorscheme saml
set showmatch
set ignorecase
set showmode
set ts=4
set sw=4
set autoindent
set smartindent

" Enable file type plugins
filetype plugin on
let g:pydiction_location='~/.vim/pydiction-1.2/complete-dict'

set number
set expandtab
autocmd FileType python runtime! autoload/pythoncomplete.vim
imap <c-space> <c-x><c-o>
:set backspace=2
if has("autocmd")
            autocmd FileType python set complete+=k/home/samuel/.vim/pydiction-1.2/pydiction isk+=.,(
                    endif " has("autocmd"

                    filetype plugin on
                    filetype indent on

" Mappings
                    nmap <C-N> :noh <CR>
