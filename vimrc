"a lot of this is inspired by
"http://stevelosh.com/blog/2010/09/coming-home-to-vim
"pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"basic stuff
"break vi compatibility to allow lots of features.
set nocompatible
"hide buffers rather than closing them
set hidden
"change the leader to ,
let mapleader = ","
set grepprg=grep\ -nH\ $*

" Backups {{{
"set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.
" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"
" }}}

"escape with jj and enter commands with ;
inoremap jj <ESC>
inoremap <C-j> <ESC>
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

"SYNTAX
syntax on
filetype on
filetype plugin indent on

" COLOURS
set background=dark
" 256 colour
set t_Co=256
color zenburn
nnoremap <leader>bw :colorscheme badwolf<CR> 

" function! Zenburn_Toggle ()
    " if ! exists("g:zenburn_high_Contrast")
        " let g:zenburn_high_Contrast = 1
        " colorscheme zenburn
    " elif exists("g:zenburn_high_Contrast")
        " let g:zenburn_high_Contrast = 1
        " colorscheme zenburn
    " endif
" endfunction
"nnoremap <leader>zb :call Zenburn_Toggle ()<CR>
nnoremap <leader>zb :colorscheme zenburn<CR>
nnoremap <leader>zbh :let g:zenburn_high_Contrast = 1<CR>
nnoremap <leader>zbl :let g:zenburn_high_Contrast = 0<CR>


" GENERAL
set encoding=utf-8
set ruler
set cursorline
set ttyfast
set backspace=indent,eol,start
set autoread
set autowrite
set shiftround
" set showbreak=↪
set modelines=0
set history=1000
" set list
" set listchars=tab:▸\ ,extends:❯,precedes:❮
"don't wrap lines
set nowrap
"toggle line numbers
set numberwidth=1
nnoremap <leader>n :set invnumber<CR>
"enable paste mode, so that pasted text doesn't have cascading indentation
set pastetoggle=<F2>
set scrolloff=15
"formatting of text. place cursor in paragraph or visually select.
vmap Q gq
nmap Q gqap

" Save when losing focus
au FocusLost * :wa

" TABS
" Mostly to make python look nice
set tabstop=4
set shiftwidth=4
set expandtab
"expand tab can be annoying as it means backspacing over multiple
"spaces to get back to no tabs. this is solved by softtabstop
"also solves compatibility issues between different editors
set softtabstop=4
"new line has the same indentation as previous line
set autoindent

" KILL TRAILING WHITESPACE
" and maintain cursor position
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre *.py :call <SID>StripTrailingWhitespaces()

" FUGITIVE 
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gs :Gstatus<CR>

" STATUSLINE
set laststatus=2
set statusline=
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
" fugitive
set statusline+=%{fugitive#statusline()}  
" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" flake8 (press F7 to get pep8 and pyflakes check)
" run on file write
" autocmd BufWritePost *.py call Flake8()
" ignore no double spaces between functions errors
let g:flake8_ignore="E302"
"E501"

"stop f1 from ruining everything
noremap  <F1> <ESC>
inoremap <F1> <ESC>

"FOLDING
set foldmethod=indent
set foldnestmax=1
nnoremap <SPACE> za

" WINDOWS
"open and switch to new window
nnoremap <leader>w <C-w>v<C-w>l

"easy movement around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Restate this window command after vim has started up
" (i.e. after vimrc, plugins have been read in).
" Still haven't figured out what causes this to be rewritten
" in the first place!
" Think it is from vim-latex. c-j is used to jump around
" placeholders.
autocmd VimEnter * nnoremap <C-j> <C-w>j
" Same for the alternative escape command...
autocmd VimEnter * inoremap <C-j> <ESC>

"resizing windows
nnoremap <C--> <C-W>-
nnoremap <C-=> <C-W>+

" Resize splits when the window is resized
au VimResized * :wincmd =


" SEARCH
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
"press f3 and the code will be turned into its output. changing python for 
"e.g. bash will allow its output to be easily inserted into the file.
"http://stackoverflow.com/questions/501585
:vnoremap <f3> :!python<CR>

let g:pep8_map='<leader>8'

" http://vim.wikia.com/wiki/Quickly_adding_and_deleting_empty_lines 
" Ctrl-Down/Up deletes blank line below/above, and Up/Down inserts. 
nnoremap <silent><C-Down> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-Up> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><Up> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><Down> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" TASKLIST
map <leader>td <Plug>TaskList

" GUNDO
nnoremap <F5> :GundoToggle<CR>

"Supertab
"I want literal tabs!!!
"let g:SuperTabMappingForward = '<s-tab>'
"let g:SuperTabMappingBackward = 's-space>'
"tab completion and python documentation
"hit <leader>pw for pydoc on a function
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" PYTHON 
" tab completion
au FileType python set omnifunc=pythoncomplete#Complete
" automatically wrap comments to 68 characters
au FileType python set tw=68
au FileType python set formatoptions=cqa

" VIM - LATEX
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'

" NERD Tree
noremap <F9> :NERDTreeToggle<CR>
inoremap <F9> <esc>:NERDTreeToggle<CR>

au Filetype nerdtree setlocal nolist

let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = []

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" /NERDTree

" NERDCommenter
let NERDSpaceDelims = 1
" /NERDCommenter

"Markdown
"interpret .md as markdown rather than modula
autocmd! filetypedetect BufNewFile,BufRead *.md setfiletype markdown
"Add headings
nnoremap <buffer> <leader>1 yypVr=
nnoremap <buffer> <leader>2 yypVr-
nnoremap <buffer> <leader>3 I### <Esc>A ###<Esc>
nnoremap <buffer> <leader>4 I#### <Esc>A ####<Esc>
nnoremap <buffer> <leader>5 I##### <Esc>A #####<Esc>
" Add emphasis
nnoremap <leader>b bi*<Esc>ea*<Esc>
" /Markdown

"Ctrl-P
" need to ignore .git here rather than in wildignore else fugitive breaks.
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

" Open url in firefox
" based on http://vim.wikia.com/wiki/VimTip306
"function! Browser ()
    "let line = getline (".")
    "let line = matchstr (line, "\%(http://\|www\.\)[^ ,;\t]*")
    "exec "!firefox ".line
"endfunction
"map <leader>o :call Browser ()<CR>
map <leader>o :!urlview % <CR>

" Live word count
" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim 
function! WordCount()
    let s:old_status = v:statusmsg
    let position = getpos(".")    
    exe ":silent normal g\<c-g>"
    let stat = v:statusmsg
    let s:word_count = 0 
    if stat != '--No lines in buffer--'
        let s:word_count = str2nr(split(v:statusmsg)[11])
        let v:statusmsg = s:old_status
    end
    call setpos('.', position) 
    return s:word_count
endfunction
:set statusline+=wc:%{WordCount()}
" This seems to break basic typing. The first character is pushed ahead of
" the rest! now modified to fix this - see Daak in SO thread. 
" Easiest to just do g<c-g> in command mode. 
