"--------------------------------------------
" General stuff
" --------------------------------------------
let mapleader = ','    " Use , as leader key
set hlsearch         " Highlight search results
set backspace=2      " Make backspace work like most other apps
set splitright
set splitbelow

" --------------------------------------------
" Code display
" --------------------------------------------
syntax on                " Turn on syntax highlighting
set nowrap               " Don't wrap text that goes outside the screen
set scrolloff=12         " Ensure to always see some lines of context
set showmatch            " Highlight matching braces
set showmode             " Show in which editing mode you currently are

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
" Remap Ctrl + S to save, in all modes:
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <ESC>:update<CR>
inoremap <silent> <C-S>         <ESC>:update<CR>

" Turn of vim's increment command
nnoremap <silent> <C-A>  <Nop>
vnoremap <silent> <C-A>  <Nop>
inoremap <silent> <C-A>  <Nop>
" Turn of vim's decrement command
"nnoremap <silent> <C-X>  <Nop>
"vnoremap <silent> <C-X>  <Nop>
"inoremap <silent> <C-X>  <Nop>

" Split editor window vertically
nnoremap <C-I> :vs<CR>
" Open .vimrc
nnoremap <C-E> :vs ~/.config/nvim/init.lua<CR>
" Open today's journal
let $journalfile="/home/shl/journal/" . strftime("%Y.md")
nnoremap <C-J> :vs $journalfile<CR>
" Refresh vim
nnoremap <F5> :source ~/.vimrc<CR>
" Close window
nnoremap <C-Q> :q<CR>
" Format with black
nnoremap <C-B> :Black<CR>
" Esc on Alt+Q
inoremap <M-Q> <ESC>

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

" Cyanic color scheme
Plug 'rktjmp/lush.nvim'
Plug 'samuell/cyanic.nvim'

" Python stuff
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' } " https://github.com/hanschen/vim-ipython-cell
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'psf/black', { 'branch': 'stable', 'for': 'python' }

" Go stuff
Plug 'fatih/vim-go', { 'for': [ 'go', 'go2' ] }

" Rust stuff
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer'
set hidden
let g:racer_cmd = "/home/shl/.cargo/bin/racer"
let g:racer_experimental_completer = 1

" Nextflow
Plug 'Mxrcon/nextflow-vim'

augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
    autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
    autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
    autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
    autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
    noremap <silent> <C-F>          :RustFmt<CR>
    vnoremap <silent> <C-F>         <ESC>:RustFmt<CR>
    inoremap <silent> <C-F>         <ESC>:RustFmt<CR>
augroup END

" Crystal stuff
Plug 'vim-crystal/vim-crystal'

" Vim wiki
Plug 'vimwiki/vimwiki'

" Fzf support
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Ctrl+P support
Plug 'kien/ctrlp.vim'

" Nerd tree
Plug 'preservim/nerdtree'

" Tagbar
Plug 'preservim/tagbar'

" TOML syntax highlightign
Plug 'cespare/vim-toml'

" Quarto
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'quarto-dev/quarto-vim'

" NvimColorizer
Plug 'norcalli/nvim-colorizer.lua'

" Initialize plugin system
call plug#end()

" ---------------------------------------------------------------------------
" Vim IPython Cell / Slime
" ---------------------------------------------------------------------------

let g:slime_target = "tmux"

let g:ipython_cell_delimit_cells_by = 'tags'
let g:ipython_cell_valid_marks = [ '# %%' ]

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

" ---------------------------------------------------------------------------
" Jedi config
" ---------------------------------------------------------------------------
au BufNewFile,BufRead *.py nnoremap gd :call jedi#goto()<CR>

" ---------------------------------------------------------------------------
" NERD Tree
" ---------------------------------------------------------------------------
let NERDTreeIgnore=['\.pyc', '\~$']
let NERDTreeShowHidden=1
nnoremap <c-f> :NERDTreeFocus<CR>
nnoremap <c-n> :NERDTree<CR>
nnoremap tt :NERDTreeToggle<CR>
nnoremap ff :NERDTreeFind<CR>

" ---------------------------------------------------------------------------
" Ctrl-P Config
" ---------------------------------------------------------------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Search all subfolders of the path that Vim was started in, not the currently
" open file.
let g:ctrlp_working_path_mode = 0
" Custom find command to find hidden files as well
let g:ctrlp_user_command = 'find %s -type f -not -path "*/.git/*" -not -path "*/__pycache__/*"'

" ---------------------------------------------------------------------------
" FZF Config
" ---------------------------------------------------------------------------
" Initialize configuration dictionary
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']

noremap <c-g> :Rg<Cr>
noremap <c-c> :Commits<Cr>
"noremap <c-i> :Files<Cr>
"From https://github.com/junegunn/fzf/issues/453
noremap <silent> <expr> <c-i> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-l>" : '').":Files\<cr>"

" ---------------------------------------------------------------------------
" Vim-Go config
" ---------------------------------------------------------------------------
let g:go_fmt_command = "goimports"

" ---------------------------------------------------------------------------
" Tagbar Config
" ---------------------------------------------------------------------------
nmap <F8> :TagbarToggle<CR>

" ---------------------------------------------------------------------------
" Snakefile syntax highlightign
" ---------------------------------------------------------------------------
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake

" ---------------------------------------------------------------------------
" Cursorline config (Needs to be last, as otherwise overwritten by something
" else)
" ---------------------------------------------------------------------------
set cursorline
hi CursorLine cterm=NONE ctermbg=darkgrey


" ---------------------------------------------------------------------------
" Misc fixes
" ---------------------------------------------------------------------------
" Fix broken syntax highlighting for long lines.
" See: https://github.com/vim/vim/issues/2790
syntax sync minlines=10000
noremap <c-x> :syntax sync minlines=10000<Cr>

colorscheme cyanic " Set the color scheme
