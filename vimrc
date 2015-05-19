" VIM rc file
" Created by Gonzalo Alvarez
"
" Commonly used commands:
" F2 - NerdTree
" F3 - Show hidden chars
" F4 - Paste mode
" F5
" F6 
" F7
" F8 
" F9 - Show line numbers
" F10 - Status bar toggle
" F11
" F12
" <Ctrl-A> - Select all
" <Ctrl-P> - Recent files behaviour
" ,cc - Comment block or line
" ,cx - Uncomment block or line
" ,s  - Signify toggle
" ,/  - Disable search highlight

" Not compatible is ok
set nocompatible

" Syntax highlighting
sy on
filetype on
filetype plugin on
filetype indent on

" Make buffers hidden on change view, not force save
set hidden

" And enable it by default
set number

" Show airline always and set preferences
set laststatus=2

" Show search matches as you type
set incsearch

" Living on the wild side. No backup and no swap file
set nobackup
set noswapfile

" Pretty basic stuff. No wrap and no rl, obviously.
set nowrap
set norl

" Tab manage
set ts=4
set softtabstop=4
set shiftround
set cindent
set shiftwidth=4
set expandtab

" Change leader key to ,
let mapleader = ","

" I hate noise. The t_vb bit removes any delay also
set visualbell t_vb=

" Always show cursor position
set ruler

" Search highlight
set hlsearch

" For fast terminals can highlight search string as you type
set incsearch

" Allow switching buffers without writing to disk
set hidden

" Usually I don't care about case when searching
set ignorecase

" Redraw only when needed
set lazyredraw

" Only ignore case when we type lower case when searching
set smartcase

" Set terminal title to filename
set title

" Show menu with possible tab completions
set wildmenu

" Ignore these files when completing names and in Explorer
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif

" Allow backspacing over everything in insert mode
set bs=2
" Read/write a .viminfo file, don't store more
" than 50 lines of registers
set viminfo='20,\"50
" Keep 50 lines of command line history
set history=50

" Visual selection automatically copied to the clipboard
set go+=a

" The following will make tabs and trailing spaces visible when requested
set listchars=nbsp:.,tab:>-,trail:.,eol:$
nmap <silent> <F3> :set nolist!<CR>

" Disable highlight when I finished searching
nmap <silent> <leader>/ :nohlsearch<CR>

" Put a list of buffers with airline on the top
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tagbar#enabled = 0

" set to HOME_INIT_PATH the path of the 
let g:HOME_INIT_PATH = expand("$HOME/.vim")
" Load any other plugin installed in home
let g:HOME_RC_SCRIPTS = split(expand(g:HOME_INIT_PATH."/*.vim"),"\n")
for fl in g:HOME_RC_SCRIPTS
    if filereadable(fl)
        exec "source ". fl
    endif
endfor

if exists('$ECLIM_ENABLED')
    exec "source ". g:HOME_INIT_PATH . "/eclim/eclim.vim"
endif

function SetMarkdownOptions()
    set wrap
    set linebreak
    set nolist
    set textwidth=0
    set wrapmargin=0
    set display+=lastline
    " Remaps to navigate within wrapped lines
    map <silent> <Up> gk
    imap <silent> <Up> <C-o>gk
    map <silent> <Down> gj
    imap <silent> <Down> <C-o>gj
    map <silent> <home> g<home>
    imap <silent> <home> <C-o>g<home>
    map <silent> <End> g<End>
    imap <silent> <End> <C-o>g<End>
endfunction

"Run the autocmd scripts
if has('autocmd')
    " Bash shell binds
    autocmd VimEnter *.sh setlocal filetype=sh
    autocmd FileType sh nnoremap <silent> <F6> :exec "! bash ". expand("%:p")<CR>
    autocmd FileType sh inoremap <silent> <F6> <Esc>:exec "! bash ". expand("%:p")<CR>
    " Python binds
    autocmd VimEnter *.py setlocal filetype=python
    autocmd FileType python setlocal complete+=k
    exec "autocmd FileType python setlocal dict+=". expand("<sfile>:p:h") ."/dicts/python.dict"
    autocmd FileType python setlocal isk+=.,(
    autocmd VimEnter *.py setlocal complete+=k
    " C binds
    autocmd VimEnter *.c setlocal filetype=c
    autocmd FileType c,cpp nnoremap <silent> <F6> :make<CR>
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal g'\"" | endif
    " CSS Less files syntax hightlight
    autocmd VimEnter *.less setlocal filetype=less
    autocmd VimEnter *.yaml,*.yml setlocal filetype=yaml
    " Markdown files syntax highlight
    autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=mkd
    autocmd FileType mkd call SetMarkdownOptions()
    " NodeJS dict binding
    exec "autocmd FileType javascript setlocal dict+=". expand("<sfile>:p:h") ."/dicts/node.dict"
    " JSP/XML
    autocmd FileType jsp,xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType jsp,xml inoremap </ </<C-X><C-O>
    " Eclim
    if exists('$ECLIM_ENABLED')
        exec "autocmd FileType java source ". g:HOME_INIT_PATH . "/eclim/java.vim"
    endif
    " Logs
    autocmd BufRead,BufNewFile */var/output/logs/* setlocal filetype=messages
    autocmd FileType messages set wrap
endif

" The % key will switch between opening and closing brackets for EVERYTHING
runtime macros/matchit.vim

" This follows the mouse on click. Pretty nice.
if has('mouse')
    set mouse=n
    set mouse+=v
endif

" Autocomplete parenthesis, brackets and braces
vnoremap ( s()<Esc>P
vnoremap [ s[]<Esc>P
vnoremap { s{}<Esc>P

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
nnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-S to save
nnoremap <silent> <C-S> :<C-u>Update<CR>
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" F11 show/hide line numbers
nnoremap <silent> <F9>  :set invnumber number?<CR>

" F2 to show and hide NERD Tree
nnoremap <silent> <F2> :NERDTreeToggle<CR>

" Configure nerdtree to ignore some files
let NERDTreeIgnore=[ '\.o$', '\.swp$', '\~$', '\.class$' ]

" Remap the Autocomplete C-n to C-Space
if has('gui')
    if has('unix')
        inoremap <Nul> <C-n>
    else
        inoremap <C-Space> <C-n>
    endif
else
    inoremap <Nul> <C-n>
endif

" snippetsMate configuration
let g:snips_author = "Gonzalo Alvarez"
ino <silent> <tab> <c-r>=TriggerSnippet()<cr>
snor <silent> <tab> <esc>i<right><c-r>=TriggerSnippet()<cr>
ino <silent> <s-tab> <c-r>=BackwardsSnippet()<cr>
snor <silent> <s-tab> <esc>i<right><c-r>=BackwardsSnippet()<cr>
ino <silent> <c-r><tab> <c-r>=ShowAvailableSnips()<cr>
au VimEnter * call GetSnippets(g:HOME_INIT_PATH. "/snippets", '_')
au FileType * if &ft != 'help' | call GetSnippets(g:HOME_INIT_PATH. "/snippets", &ft) | endif

" comments configuration
" key-mappings for comment line in normal mode
noremap  <silent> <leader>cc :call CommentLine()<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
vnoremap <silent> <leader>cc :call RangeCommentLine()<CR>
" key-mappings for un-comment line in normal mode
noremap  <silent> <leader>cx :call UnCommentLine()<CR>
" key-mappings for range un-comment lines in visual <Shift-V> mode
vnoremap <silent> <leader>cx :call RangeUnCommentLine()<CR>

" Signify plugin bindings and confs
let g:signify_disable_by_default = 1
nnoremap <silent> <leader>s :SignifyToggle<Cr>

" Paste toggle to allow easy pasting
set pastetoggle=<F4>

" Some help in window navigation
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-k> <C-w>k
map <C-j> <C-w>j

" Enable full colors if available
if &term == "xterm" || &term == "screen-bce"
    set t_Co=256
    colorscheme charged-256
endif

" Set the right encoding
set encoding=utf-8

" highlight signs in Sy
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Ctrlp mappings
let g:ctrlp_working_path_mode = 'ra'
nnoremap <silent> <leader>pp :CtrlP<CR>
nnoremap <silent> <leader>pb :CtrlPBuffer<CR>
nnoremap <silent> <leader>pr :CtrlPMRU<CR>
nnoremap <silent> <leader>pa :CtrlPMixed

" Fugitive bindings
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>

" Buffers instead of tabs. See: https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
set hidden
nnoremap <silent> <C-T> :enew<CR>
nnoremap <silent> <C-Left> :bprevious<CR>
nnoremap <silent> <C-Right> :bnext<CR>
nnoremap <silent> <C-Q> :bp <BAR> bd #<CR>

" Move around windows
nnoremap <silent> <A-Up> :wincmd k<CR>
nnoremap <silent> <A-Down> :wincmd j<CR>
nnoremap <silent> <A-Left> :wincmd h<CR>
nnoremap <silent> <A-Right> :wincmd l<CR>

" Nice trick to automatically detect bash files
function! RedetectFiletype()
    if getpos(".")[1] == 1 && getline(1) =~ '^#!'
        filetype detect
    endif
endfunction
inoremap <CR>:call RedetectFiletype()<CR>a<CR>
