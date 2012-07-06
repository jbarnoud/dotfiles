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

set autowrite " Automatically save before commands like :next and :make
set pastetoggle=<F2>

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.


filetype plugin on
filetype indent on

autocmd FileType python compiler pylint
let g:pylint_onwrite = 0

set autochdir

vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
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

" Set path for LangageTool grammar checking
let g:languagetool_jar=$HOME . '/src/languagetool/dist/LanguageTool.jar'

" Change the laeder from \ to !
let mapleader="!"

" Create shortcuts
command TT TlistToggle
command CT !ctags -R

" Taglist
let Tlist_Auto_Update = 1

" Navigation between splited windows using Alt+arrow
" http://vim.wikia.com/wiki/Switch_between_Vim_window_splits_easily
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
imap <silent> <A-Up> <ESC>:wincmd k<CR>a
imap <silent> <A-Down> <ESC>:wincmd j<CR>a
imap <silent> <A-Left> <ESC>:wincmd h<CR>a
imap <silent> <A-Right> <ESC>:wincmd l<CR>a

"TAB navigation
nmap <C-Left> :tabprevious<cr>
nmap <C-Right> :tabnext<cr>
imap <C-Left> <ESC>:tabprevious<cr>a
imap <C-Right> <ESC>:tabnext<cr>a
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>a
map <C-w> :tabclose<cr>
imap <C-w> <ESC>:tabclose<cr>

" Smart home and smart end
" http://vim.wikia.com/wiki/Smart_home
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
"noremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_')
"vnoremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')
imap <Home> <C-o><Home>
"imap <End> <C-o><End>
