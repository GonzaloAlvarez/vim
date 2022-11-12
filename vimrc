" VIM rc file
" Created by Gonzalo Alvarez
"

"#######################
" General Configuration
"#######################

" Not compatible is ok
set nocompatible

" Syntax highlighting
sy on
filetype on
filetype plugin on
filetype indent on

" Make sure we use the right shell - https://stackoverflow.com/questions/12230290/vim-errors-on-vim-startup-when-run-in-fish-shell
set shell=/bin/bash

" Make buffers hidden on change view, not force save
set hidden

" And enable it by default
set number

" Show airline always and set preferences
set laststatus=2

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
let g:mapleader = ","

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
set ttyfast
set updatetime=250

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

" Check and store which OS we are running on
let uname = substitute(system('uname'), '\n', '', '')

" CtrlP configuration
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co - exclude-standard', 'find %s -type f | grep -v .DS_Store']

" Put a list of buffers with airline on the top
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tagbar#enabled = 0

let g:airline#extensions#systastic#enabled = 1

" set to HOME_INIT_PATH the path of the 
let g:HOME_INIT_PATH = expand("$HOME/.vim")
" Load any other plugin installed in home
let g:HOME_RC_SCRIPTS = split(expand(g:HOME_INIT_PATH."/*.vim"),"\n")
for fl in g:HOME_RC_SCRIPTS
    if filereadable(fl)
        exec "source ". fl
    endif
endfor

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

function SetCoffeeOptions()
    set ts=2
    set softtabstop=2
    set shiftwidth=2
    set cindent
    setlocal comments=:# commentstring=#\ %s
endfunction

function SetJadeOptions()
    set ts=2
    set softtabstop=2
    set shiftwidth=2
    setlocal comments=://-,:// commentstring=//\ %s
endfunction

function SetYamlOptions()
    setlocal sw=2 ts=2 sts=2 et
    setlocal nosmartindent
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
    autocmd VimEnter *.py map <silent> w <Plug>CamelCaseMotion_w
    autocmd VimEnter *.py map <silent> b <Plug>CamelCaseMotion_b
    autocmd VimEnter *.py map <silent> e <Plug>CamelCaseMotion_e
    autocmd BufRead,BufNewFile *.py match BadWhitespace /\s\+$/
    " C binds
    autocmd VimEnter *.c setlocal filetype=c
    autocmd FileType c,cpp nnoremap <silent> <F6> :make<CR>
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal g'\"" | endif
    " CSS Less files syntax hightlight
    autocmd VimEnter *.less setlocal filetype=less
    " Yaml files
    autocmd VimEnter *.yaml,*.yml setlocal filetype=yaml
    autocmd FileType yaml call SetYamlOptions()
    " Markdown files syntax highlight
    autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=mkd
    autocmd FileType mkd call SetMarkdownOptions()
    " NodeJS dict binding
    exec "autocmd FileType javascript setlocal dict+=". expand("<sfile>:p:h") ."/dicts/node.dict"
    " JSP/XML
    autocmd FileType jsp,xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType jsp,xml inoremap </ </<C-X><C-O>
    " Logs
    autocmd BufRead,BufNewFile */var/output/logs/* setlocal filetype=messages
    autocmd FileType messages set wrap
    " Mason
    autocmd BufNewFile,BufRead *.m,*.mi set filetype=mason
    autocmd FileType mason setlocal commentstring=#\ %s
    " Typescript
    autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript
    " JSON
    autocmd BufNewFile,BufRead *.json,*.jsonp setlocal filetype=json
    " Terraform
    autocmd BufNewFile,BufRead *.tf setlocal filetype=terraform
    autocmd FileType terraform call SetYamlOptions()
    " Jade
    autocmd BufNewFile,BufRead *.jade setlocal filetype=pug
    autocmd FileType pug call SetJadeOptions()
    " CoffeeScript
    autocmd BufNewFile,BufRead *.coffee setlocal filetype=coffee
    autocmd FileType coffee call SetCoffeeOptions()
endif

" The % key will switch between opening and closing brackets for EVERYTHING
runtime macros/matchit.vim

" This follows the mouse on click. Pretty nice.
if has('mouse')
    set mouse=n
    set mouse+=v
endif

" Nice trick to automatically detect bash files
function! RedetectFiletype()
    if getpos(".")[1] == 1 && getline(1) =~ '^#!'
        filetype detect
    endif
endfunction
inoremap <CR>:call RedetectFiletype()<CR>a<CR>

" Autocomplete parenthesis, brackets and braces
vnoremap ( s()<Esc>P
vnoremap [ s[]<Esc>P
vnoremap { s{}<Esc>P

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

" Signify plugin bindings and confs
let g:signify_disable_by_default = 1

" Enable full colors if available
set t_Co=256
colorscheme gtorte

" Set the right encoding
set encoding=utf-8

" highlight signs in Sy
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

"######################
" BINDINGS
"######################

" Show/hide hidden chars
nmap <silent> <leader>l :set nolist!<CR>

" Paste toggle to allow easy pasting
set pastetoggle=<leader>P

" Show and hide NERD Tree
nnoremap <silent> <leader>t :NERDTreeToggle<CR>

" Hide nerd tree once we opened the file
let NERDTreeQuitOnOpen = 1

" Signify plugin
nnoremap <silent> <leader>s :SignifyToggle<Cr>

" Comments configuration
noremap  <silent> <leader>cc :call CommentLine()<CR>
vnoremap <silent> <leader>cc :call RangeCommentLine()<CR>
noremap  <silent> <leader>cx :call UnCommentLine()<CR>
vnoremap <silent> <leader>cx :call RangeUnCommentLine()<CR>

" Some help in window navigation
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-k> <C-w>k
map <C-j> <C-w>j

" Ctrlp mappings
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
nnoremap <silent> <leader>bc :enew<CR>
nnoremap <silent> <leader><s-tab> :bprevious<CR>
nnoremap <silent> <leader><tab> :bnext<CR>
nnoremap <silent> <leader>q :bp <BAR> bd #<CR>
nnoremap <leader>be :e

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
nnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" Easy save
nnoremap <silent> <C-S> :<C-u>Update<CR>
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Disable highlight when I finished searching
nmap <silent> <leader>/ :nohlsearch<CR>

" Keep visual lines enabled when identing
vnoremap > >gv
vnoremap < <gv

" make the highlighting of tabs less annoying
highlight SpecialKey ctermbg=none

" Kill arrow keys
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

" Remap vertical movement keys
nnoremap J <PageDown>
nnoremap K <PageUp>

" Kill pageup and pagedown
nnoremap <PageDown> <NOP>
nnoremap <PageUp> <NOP>

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Relative line numbers
function! NumberToggle(insert)
    if(a:insert == 1)
        if(&relativenumber == 1)
            set number
        endif
    elseif(a:insert == 2)
        if(&number == 1)
            set relativenumber
        endif
    else
        if(&relativenumber == 1)
            set number
        elseif(&number == 1)
            set invnumber
        else
            set relativenumber
        endif
    endif
endfunc

try
    set relativenumber
    nnoremap <silent> <leader>m :call NumberToggle(0)<CR>
    " Show absolute numbers when inserting
    autocmd InsertEnter * :call NumberToggle(1)
    autocmd InsertLeave * :call NumberToggle(2)
    autocmd BufRead * :call NumberToggle(2)
catch
    set number
endtry

" Enable merging the line number with the sign (gutter) line
set signcolumn=number

" Change color for the background of the signify background
hi clear SignColumn
hi clear SignifySignAdd
hi clear SignifySignDelete
hi clear SignifySignChange
hi clear SignifySignChangeDelete
hi clear SignifySignDeleteFirstLine

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Modify tmux window name to the file we are editing
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
autocmd VimLeave * call system("tmux rename-window bash")

" Make Sneak my default search
let g:sneak#label = 1

" Split current buffer
function WinSplit()
    let wincount = winnr('$')
    let bufcount = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
    on
    if bufcount > 1 && wincount == 1
        vsp | b#
    endif
endfunc

nmap <leader>w :call WinSplit()<CR>
nmap <leader>W <C-w>w

" Manage Syntastic
let g:syntastic_check_on_open = 1
if uname == "Linux"
    let g:syntastic_error_symbol = "\u27a4"
else
    let g:syntastic_error_symbol = "\u2B22"
endif
let g:syntastic_warning_symbol = "\u2755"
let g:syntastic_style_warning_symbol = "\u2755"
let g:syntastic_style_error_symbol = "\u2B22"
let g:syntastic_quiet_messages = { "level": "warnings" }
let g:syntastic_enable_highlighting = 0
let g:syntastic_enable_balloons = 1
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_compiler_options = "-std=c99 -Wall -Werror"
let g:syntastic_python_flake8_args='--max-line-length=120 --ignore=E128'


nmap <leader>r :SyntasticToggleMode<CR>
