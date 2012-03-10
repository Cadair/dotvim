"pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"basic stuff
"break vi compatibility to allow lots of features.
set nocompatible
"don't create a backup file
set nobackup
"hide buffers rather than closing them
set hidden
"change the leader to a ,
let mapleader = ","
set grepprg=grep\ -nH\ $*

" Backups {{{
"set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.
" }}}

"SYNTAX
syntax on
filetype on
filetype plugin indent on

set background=dark
" 256 colour
set t_Co=256
color zenburn

set encoding=utf-8
set ruler
set cursorline
set ttyfast
set backspace=indent,eol,start
set autoread
set autowrite
set shiftround
set showbreak=↪
set modelines=0
set history=1000
set list
" set listchars=tab:▸\ ,extends:❯,precedes:❮

set laststatus=2
set statusline=
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
" fugitive
" set statusline+=%{fugitive#statusline()}  
" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*


" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" Save when losing focus
au FocusLost * :wa

" Resize splits when the window is resized
au VimResized * :wincmd =

"stop f1 from ruining everything
noremap  <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a

" see http://sontek.net/turning-vim-into-a-modern-python-ide
"FOLDING
"set foldmethod=indent
"set foldlevel=99

"TASKLIST
map <leader>td <Plug>TaskList

"Supertab
"I want literal tabs!!!
"let g:SuperTabMappingForward = '<s-tab>'
"let g:SuperTabMappingBackward = 's-space>'
"tab completion and python documentation
"hit <leader>pw for pydoc on a function
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

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

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'


"don't wrap lines
set nowrap
"toggle line numbers
set numberwidth=1
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
" Ctrl-Down/Up deletes blank line below/above, and Up/Down inserts. 
nnoremap <silent><C-Down> m`:silent +g/\m^\s*$/d<CR>``:noh<CR> 
nnoremap <silent><C-Up> m`:silent -g/\m^\s*$/d<CR>``:noh<CR> 
nnoremap <silent><Up> :set paste<CR>m`o<Esc>``:set nopaste<CR> 
nnoremap <silent><Down> :set paste<CR>m`O<Esc>``:set nopaste<CR> 

" NERD Tree
noremap <F9> :NERDTreeToggle<CR>
inoremap <F9> <esc>:NERDTreeToggle<CR>

au Filetype nerdtree setlocal nolist

let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = []

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" /NERDTree

"Markdown
"Add headings
nnoremap <buffer> <leader>1 yypVr=
nnoremap <buffer> <leader>2 yypVr-
nnoremap <buffer> <leader>3 I### <Esc>A ###<Esc>

"Ctrl-P
" need to ignore .git here rather than in wildignore or 
" fugitive breaks.
" let g:ctrlp_custom_ignore = '\.git$'
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'


"Wildmenu
"This is for command completion and alternative display
set wildmenu
set wildmode=longest:full

" don't ignore git here or fugitive breaks
" set wildignore+=*/.hg/*,*/.svn*,
set wildignore+=*.aux,*.out,*.toc                " Latex intermediatries
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files

set wildignore+=*.luac                           " Lua byte code

set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code

set wildignore+=*.orig                           " Merge resolution files


"Line return
" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

