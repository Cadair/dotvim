call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax enable
set background=dark
"change the leader to a ,
let mapleader = ","

"Stuff to make python look nice
set tabstop=4
set shiftwidth=4
set expandtab
"expand tab can be annoying as it means backspacing over multiple
"spaces to get back to no tabs. this is solved by softtabstop
"also solves compatibility issues between different editors
set softtabstop=4
"new line has the same indentation as previous line
set autoindent


filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'

"break vi compatibility to allow lots of features.
set nocompatible
"don't create a backup file
set nobackup
"hide buffers rather than closing them
set hidden

"don't wrap lines
set nowrap
"toggle line numbers
nnoremap <leader>n :set invnumber<CR>

"enable paste mode, so that pasted text doesn't have cascading indentation
set pastetoggle=<F2>

"formatting of text. place cursor in paragraph or visually select.
vmap Q gq
nmap Q gqap

"a lot of this is inspired by
"http://stevelosh.com/blog/2010/09/coming-home-to-vim
"escape with jj and enter commands with ;
inoremap jj <ESC>
nnoremap ; :
"Disable the arrow keys
"see jeetworks.org/node/89
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

set encoding=utf-8
set ruler

"open and switch to new window
nnoremap <leader>w <C-w>v<C-w>l

"easy movement around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"resizing windows
nnoremap <C--> <C-W>-
nnoremap <C-=> <C-W>+

"Intelligent dealing with case-sensitive search. all-lowercase will be
"insensitive, but any uppercase will be sensitive again.
set ignorecase
set smartcase

"search highlighting. ,<space> then removes highlighting
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

"move around brackets easier
nnoremap <tab> %
vnoremap <tab> %

"quick editing and reloading of .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"quickly select just pasted text
nnoremap <leader>v V`]

"AMAZING!!! evaluation of python code. write the code, visually select and
"press f5 and the code will be turned into its output. changing python for 
"e.g. bash will allow its output to be easily inserted into the file.
"http://stackoverflow.com/questions/501585
:vnoremap <f5> :!python<CR>

let g:pep8_map='<leader>8'

" http://vim.wikia.com/wiki/Quickly_adding_and_deleting_empty_lines 
" " Ctrl-j/k deletes blank line below/above, and Up/Down inserts. 
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR> 
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR> 
nnoremap <silent><Up> :set paste<CR>m`o<Esc>``:set nopaste<CR> 
nnoremap <silent><Down> :set paste<CR>m`O<Esc>``:set nopaste<CR> 
