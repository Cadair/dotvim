"Aaron O'Leary vimrc 2012
"a lot of this is inspired by
"http://stevelosh.com/blog/2010/09/coming-home-to-vim

"pathogen
" disable python mode if vim version less than 7.3
if v:version < 703
    let g:pathogen_disabled = ['vim-python-mode']
endif
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"basic stuff
"break vi compatibility to allow lots of features.
set nocompatible
"hide buffers rather than closing them
set hidden
"change the leader to ,
let mapleader = ","
" also use \ as leader
nmap \ <leader>
set grepprg=grep\ -nH\ $*

"encoding utf-8
set enc=utf-8
set fileencoding=utf-8

" Backups {{{
"set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.
" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"
" }}}

"escape with jk and enter commands with ;
inoremap jk <ESC>
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

" use the mouse for scrolling
" set mouse=a
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
nnoremap <leader>N :set invrelativenumber<CR>
"enable paste mode, so that pasted text doesn't have cascading indentation
set pastetoggle=<F2>
set scrolloff=999
"stop f1 from ruining everything
noremap  <F1> <ESC>
inoremap <F1> <ESC>
"auto formatting of text to match the set linewidth (default 79)
"place cursor in paragraph or visually select.
vmap Q gq
nmap Q gqap
nnoremap <leader>t :set tw=72<CR>
" highlight column at 80 characters
set cc=80

" Save when losing focus
au FocusLost * :wa

"SYNTAX
syntax on
filetype on
filetype plugin indent on
" fix highlighting when it messes up
nnoremap <F1> :syn sync fromstart<CR>
inoremap <F1> <C-o>:syntax sync fromstart<CR>

" Get syntax group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" COLOURS
set background=dark

" 256 colour zenburn
" set t_Co=256
" let g:zenburn_high_Contrast = 1
" colorscheme zenburn

" 16 colour Solarized - works properly this way with terminator and tmux.
" let g:solarized_termcolors=256
" make solarized use transparent background
let g:solarized_termtrans=1
colorscheme solarized

" Zenburn is great, but sometimes we need to switch to a higher
" contrast scheme for light environments.
function! Zenburn_Toggle ()
    if g:colors_name != "zenburn"
        colorscheme zenburn
    elseif g:zenburn_high_Contrast == 0
        let g:zenburn_high_Contrast = 1
        colorscheme zenburn
    elseif g:zenburn_high_Contrast == 1
        let g:zenburn_high_Contrast = 0
        colorscheme zenburn
    endif
endfunction
nnoremap <leader>zb :call Zenburn_Toggle ()<CR>
nnoremap <F8> :call Zenburn_Toggle ()<CR>
inoremap <F8> <c-o>:call Zenburn_Toggle ()<CR>
" And for something different
nnoremap <leader>bw :colorscheme badwolf<CR> 

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
nnoremap <leader>gp :Git add -p<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>ga :Git commit --amend<CR>
nnoremap <leader>gs :Gstatus<CR>

" Gitv
nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>
highlight diffAdded guifg=#00bf00
highlight diffRemoved guifg=#bf0000
set lazyredraw

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

"FOLDING
set foldmethod=indent
au FileType python set foldnestmax=2
nnoremap <SPACE> za

" WINDOWS
"open and switch to new window
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j
"easy movement around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" tile all open buffers in vertical splits
nnoremap <silent> <leader>a :vertical :ball<CR>
" focus on current window
nnoremap <silent> <leader>o :only<CR>

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
nnoremap <leader>. :noh<cr>
"select current line without indentation
nnoremap vv ^vg_

"move around brackets easier
nnoremap <tab> %
vnoremap <tab> %

"add spaces after commas on line
nnoremap <leader>, :s/,\s*/, /g<CR>:noh<CR>

"space around math operators on line
nnoremap <leader>= :s/\s*\([-+=/*<>^&!%]\+\)\s*/ \1 /g<CR>:noh<CR>

" insert spaces around character under cursor
nnoremap <leader><Space> i<space><esc>la<space><esc>h

"quick editing and reloading of .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
nmap <silent> <leader>sv :source $MYVIMRC<CR>

"quickly select just pasted text
nnoremap <leader>v V`]

"AMAZING!!! evaluation of python code. write the code, visually select and
"press f3 and the code will be turned into its output. changing python for 
"e.g. bash will allow its output to be easily inserted into the file.
"http://stackoverflow.com/questions/501585
:vnoremap <f3> :!python<CR>

" Remind me to use vim-unimpaired
nnoremap <silent><Up> :echo "Use [<Space> ! "<CR>
nnoremap <silent><Down> :echo "Use ]<Space> !"<CR>

"calculator
inoremap <C-B> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" TASKLIST
" makes a list of all fixme and todo in the file
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
" this maps the omnifunc completion (which is mapped to supertab) to the 
" pythoncomplete script (comes with vim)
" au FileType python set omnifunc=pythoncomplete#Complete
" automatically wrap comments to 68 characters
au FileType python set tw=68
au FileType python set formatoptions=cqb

" PYTHON MODE
" turn off doc window
let g:pymode_doc=0
" turn off code running
let g:pymode_run=0
" I've compiled vim specifically for canopy so this should still work
let g:pymode_virtualenv=0
" TODO: some way of toggling lint error window

" IPython
function! Start_IPython ()
    " Connect to existing kernel
    " TODO: start kernel if not exist?
    :IPython
    " completion using ipython
    " N.B. setl is local, i.e current buffer, use set for global
    au FileType python setl omnifunc=CompleteIPython
endfunction
nnoremap <leader>ip :call Start_IPython()<CR>
" TODO: resize documentation window
" TODO: command to call all imports into ipython
" TODO: make all imports when call IPython?
" TODO: evaluate gfm fenced code block
" see https://github.com/wmvanvliet/vim-ipython/commit/d077b47248213ac02e04010a2040bd8a91149165
" and https://github.com/ivanov/vim-ipython/pull/41

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
nnoremap <leader>b bi*<Esc>ea*<Esc><CR>
inoremap <C-b> <C-o>b*<Esc>ea*
" quick mmd reference
nnoremap <leader>md <C-w><C-v><C-l>:e ~/writing/notes/multimarkdown_for_scientific_writing.md<CR>
" mmd natbib ref
nnoremap <leader>nb <C-w><C-v><C-l>:e ~/writing/mmd-natbib-ref<CR>

au FileType markdown set tw=68
au FileType mmd set tw=68
au FileType mkd set tw=68
au FileType md set tw=68
" /Markdown

" Screen
" use tmux
" let g:ScreenImpl = 'Tmux'

"Ctrl-P
" need to ignore .git here rather than in wildignore else fugitive breaks.
" let g:ctrlp_custom_ignore = '\.git$'
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
" max files
let g:ctrlp_max_files = 10000
" faster file searching
if has("unix")
    let g:ctrlp_user_command = {
        \    'types': {
        \        1: ['.git/', 'cd %s && git ls-files']
        \    },
        \    'fallback': 'find %s -type f | head -' . g:ctrlp_max_files
        \ }
endif
" open new file in same window
let g:ctrlp_open_new_file = 'r'

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
"map <leader>u :call Browser ()<CR>
map <leader>u :!urlview % <CR>

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
:set statusline+=\ wc:%{WordCount()}
" This seems to break basic typing. The first character is pushed ahead of
" the rest! now modified to fix this - see Daak in SO thread. 
" Easiest to just do g<c-g> in command mode. 

" Activate code block highlighting in a restructuredtext / md file
" TODO: surely this can be extended to ctrl-p as well - to 
" allow syntax highlighting of rst / md docstrings?
function! HiPy ()
    let b:current_syntax=''
    unlet b:current_syntax
    syntax include @py syntax/python.vim
    " end=/^$\n^$/
    syntax region rstpythoncode start=/\.\. python::/ end=/^$\n^\(\s\{4,}\)\@!/ contains=@py
    " code blocks are indented by 4 spaces and started with a newline followed
    " by :::python in markdown. the start string has to include the line
    " before as this is what mkdCode does, and the match / region that 
    " starts first has priority. when they both start in the same place the
    " item defined last takes priority
    " they end when there is an empty newline followed by a non-indented line
    syntax region mdpythoncode start="^\s*\n\s\{4,}:::python" end=/^$\n^\(\s\{4,}\)\@!/ contains=@py
    " start="^\s*:::python" 
    " the markdown one keeps getting overridden by the mkdCode group
    " hi def link mdpythoncode SpecialComment

    " github flavoured markdown (code blocks fenced with ```)
    syntax region gfmpythoncode keepend start="^\s*\n^\s*```python.*$" end=/^\s*```$\n/ contains=@py
endfunction

map <leader>h :call HiPy ()<CR>

" c++ intro course
au FileType cpp set tabstop=2
au FileType cpp set shiftwidth=2
au FileType cpp set softtabstop=2
