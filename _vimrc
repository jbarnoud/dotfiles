set nocompatible

syntax on
set background=dark
set t_Co=256  " 256 color terminal

set autoindent
set expandtab
set copyindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

set encoding=utf-8

filetype plugin on
filetype indent on

autocmd FileType python compiler pylint
let g:pylint_onwrite = 0

set autochdir

"vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" Ignore unreadable or useless files when autocomplete filenames
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp

" Use pathogen to handle packages from git repo
" https://github.com/tpope/vim-pathogen
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

" Fancy status line
set guifont=Bitstream\ Vera\ Sans\ Mono\ for\ Powerline:h14
let g:Powerline_symbols = 'fancy'
set laststatus=2

let mapleader="!"
