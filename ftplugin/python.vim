" Python Configuration

let b:ale_linters = ['flake8', 'pylsp']
let b:ale_completion_enabled = 0
let b:ale_fixers = ['black']

" Make the popup menu automated
"augroup ale_hover_cursor
"  autocmd!
"  autocmd CursorHold * ALEHover
"augroup END
let g:context_menu_python = [
            \ ["Peek", "ALEHover"],
            \ ["--", ],
            \ ["Rename", "ALERename"],
            \ ["Go To Definion", "ALEGoToDefinition"],
            \ ["--", ],
            \ ["Fix Issues", "ALEFix"],
            \ ]

nnoremap <silent><leader>m :call quickui#tools#clever_context('m', g:context_menu_python, {})<cr>

let opts = {'w':600, 'h':800, 'callback':'TermExit'}
let opts.title = 'TIG POP'
nmap <silent> <leader>r :call quickui#terminal#open('/bin/bash', opts)<CR>
let g:ale_python_pylsp_config = {
\   'pylsp': {
\     'plugins': {
\       'flake8': {
\         'enabled': v:false,
\       },
\       'pycodestyle': {
\         'enabled': v:false,
\       },
\       'pyflakes': {
\         'enabled': v:false,
\       },
\       'pydocstyle': {
\         'enabled': v:false,
\       },
\     },
\   },
\}
