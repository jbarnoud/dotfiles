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
"set showmatch           " Show matching brackets.

colorscheme inkpot

filetype plugin on
filetype indent on

autocmd BufWritePre *.gro call Update_number_of_atoms()
autocmd FileType mdp.gromacs set omnifunc=mdpcomplete#Complete
autocmd FileType mdp.gromacs imap <C-n> <C-x><C-o>
autocmd FileType mdp.gromacs imap <silent> <buffer> = = <C-X><C-O>

function! Meet(text)
    return len(a:text)
endfunction

function! DoNothing()
    return 1
endfunction

let g:acp_behavior = {'mdp.gromacs': [{'command' : "\<C-x>\<C-o>",
    \ 'commandfunc': 'mdpcomplete#Complete',
    \ 'meets': 'Meet', 'onPopupClose': 'DoNothing', 'repeat': 1}],
                     \'*': []}

autocmd FileType python compiler pylint
let g:pylint_onwrite = 0

" Working directory is the document directory
"set autochdir
autocmd BufEnter * silent! lcd %:p:h

" Vertical split open at the right
set splitright

vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
imap <C-v> <ESC>:call setreg("\"",system("xclip -o -selection clipboard"))<CR>p<CR>i

" Ignore unreadable or useless files when autocomplete filenames
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp
set wildignore+=*~,*.pyc

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

" Color the 80th column
if exists('+colorcolumn')
    set colorcolumn=81
endif

" Backspace should work
set backspace=indent,eol,start

" Taglist
let Tlist_Auto_Update = 1
" Close VIM if taglist is the only window
let Tlist_Exit_OnlyWindow = 1

" Gundo
" http://sjl.bitbucket.org/gundo.vim/
nnoremap <F5> :GundoToggle<CR>

" PEP8
let g:pep8_map='<F6>'

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
"map <C-w> :tabclose<cr>
"imap <C-w> <ESC>:tabclose<cr>

"Reselect visual block after indent/outdent 
vnoremap < <gv
vnoremap > >gv

" Smart home and smart end
" http://vim.wikia.com/wiki/Smart_home
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
"noremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_')
"vnoremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')
imap <Home> <C-o><Home>
"imap <End> <C-o><End>

" Resize the active window is there is more than one
" http://vim.wikia.com/wiki/VimTip427
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
  map <S-Left> <C-W>>
  map <S-Right> <C-W><
endif

"Spellcheck Git commit messages 
autocmd BufRead COMMIT_EDITMSG setlocal spell!

let g:clang_complete_copen = 1
let g:clang_complete_macros = 1
let g:clang_complete_patterns = 1
let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_use_library = 1
map <F3> <ESC>:call g:ClangUpdateQuickFix()<CR>
