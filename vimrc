"Aaron O'Leary vimrc 2012
"a lot of this is inspired by
"http://stevelosh.com/blog/2010/09/coming-home-to-vim

"pathogen
" disable python mode if vim version less than 7.3 or
" we didn't compile with python
if v:version < 703 || !has('python')
    let g:pathogen_disabled = ['vim-python-mode', 'jedi-vim']
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
set grepprg=ack

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

" Remap H and L to page up / down
nnoremap H <PageUp>
vnoremap H <PageUp>
nnoremap L <PageDown>
vnoremap L <PageDown>

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

" Shortcuts for clipboard
" copy
vnoremap <C-c> "+y
" paste
nnoremap <C-P> "+p

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

" 16 colour Solarized - works properly this way with terminator and tmux.
" let g:solarized_termcolors=256
" solarized at home
if $HOME == '/home/aaron'
    " make solarized use transparent background
    let g:solarized_termtrans=1
    colorscheme zenburn
" zenburn at work
elseif $HOME == '/nfs/see-fs-02_users/eeaol'
    let g:zenburn_high_Contrast = 1
    colorscheme zenburn
endif

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
let g:SuperTabLongestEnhanced=1

" PYTHON
" tab completion
" this maps the omnifunc completion (which is mapped to supertab) to the
" pythoncomplete script (comes with vim)
" au FileType python set omnifunc=pythoncomplete#Complete
" automatically wrap comments to 68 characters
au FileType python set tw=68
au FileType python set formatoptions=cqb

" JEDI (python autocomplete)
" turn off function argument display. This slows down text insertion when
" enabled. see https://github.com/davidhalter/jedi-vim/issues/217
let g:jedi#show_call_signatures = "0"
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#usages_command = "<leader>u"

" PYTHON MODE
" Used with Jedi for autocompletion
" see https://github.com/davidhalter/jedi-vim/issues/196
let g:pymode_rope_vim_completion=0  " no, use jedi-vim for completion
let g:pymode_run_key = "<leader>run"  " default key conflicts with jedi-vim
let g:pymode_doc_key="<leader>k"  " used jedi-vim for help
" turn off doc window
let g:pymode_doc=0
" turn off code running
let g:pymode_run=0
" Fix python paths to use virtualenvs
" for this to work with canopy I had to copy activate_this.py into
" canopy/User/bin/ from an existing virtualenv/bin
let g:pymode_virtualenv=1
" ignore from x import * and indentation
let g:pymode_lint_ignore="W0401,E127"
let g:pymode_rope=0

map <Leader>rgd :call RopeGotoDefinition()<CR>
map <Leader>pl :PyLint<CR>
let ropevim_enable_shortcuts=1
let g:pymode_rope_goto_def_newwin="vnew"
let g:pymode_rope_extended_complete=1
let g:pymode_syntax=1
let g:pymode_syntax_builtin_objs=0
let g:pymode_syntax_builtin_funcs=0
let g:pymode_lint_minheight = 5   " Minimal height of pylint error window
let g:pymode_lint_maxheight = 15  " Maximal height of pylint error window
let g:pymode_lint_write = 1  " Disable pylint checking every save
let g:pymode_lint_mccabe_complexity = 10
let g:pymode_lint_checker="pyflakes,pep8,pep257,mccabe"
let g:pymode_syntax_highlight_self=0  " do not highlight self
let g:pymode_rope_guess_project=0

function! Toggle_lint_errors ()
    " Switch off the signs column and close location window
    :sign unplace *
    :lclose
endfunction
nnoremap <leader>q :silent call Toggle_lint_errors()<CR>

" IPython
function! Start_IPython ()
    " Connect to existing kernel
    " TODO: start kernel if not exist?
    source $HOME/.vim/bundle/vim-ipython/ftplugin/python/ipy.vim
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

" code highlighting (using tpopes vim-markdown)
" TODO: makes HiPy redundant
let g:markdown_fenced_languages = ['python']

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
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
" max files
let g:ctrlp_max_files = 10000
" search within text
let g:ctrlp_extensions = ['line']
if has("unix")
    if executable('ag')
    " faster file searching using ag
        " disable caching
        let g:ctrlp_use_caching = 0
        let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
    else
        " fall back to git ls-files and then to find
        let g:ctrlp_user_command = {
            \    'types': {
            \        1: ['.git/', 'cd %s && git ls-files . --cached --exclude-standard --others']
            \    },
            \    'fallback': 'find %s -type f | head -' . g:ctrlp_max_files
            \ }
    endif
endif
" open new file in same window
let g:ctrlp_open_new_file = 'r'
" open same file in new window
let g:ctrlp_switch_buffer = 0
" shortcut to buffer mode
nnoremap <C-b> :CtrlPBuffer<CR>

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
" TODO: surely this can be extended to python-mode as well - to
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
    syntax region gfmpythoncode keepend start="^```py.*$" end=/^\s*```$\n/ contains=@py

    " also highlight the maths
    syntax include @tex syntax/tex.vim
    syn region texdisplaymaths start="\$\$" end="\$\$" skip="\\\$" contains=@texMathZoneGroup
    syn region texinlinemaths matchgroup=mkdMath start="\(\$\)\@<!\&\(\\\)\@<!\$\(\$\)\@!" end="\(\$\)\@<!\$" skip="\\\$" contains=@texMathZoneGroup
endfunction

map <leader>h :call HiPy ()<CR>

" Very useful mappings to be used with markdown and ipython
" search and select contents of fenced code blocks
nnoremap <leader>f /\v(\_^```python\n)@<=(\_.{-})(\n`{3}\_$)@=<CR>v//e<CR>
" goto the start of the current fenced code block (see :help search)
nnoremap <leader>B :call search('\n```python', 'b')<CR>
" select current code block
" TODO: use <leader> instead of ,
" TODO: cancel highlighting
nmap <leader>b ,B,f
" (or could do [b0v/\n```)
" send current code block to ipython
nmap <leader>p ,b<C-s>,.

" c++ intro course
au FileType cpp set tabstop=2
au FileType cpp set shiftwidth=2
au FileType cpp set softtabstop=2
