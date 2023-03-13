" Python Configuration

set iskeyword-=.
let b:ale_linters = ['pyright']
let b:ale_completion_enabled = 1
let b:ale_fixers = ['black']

" Make the popup menu automated
"augroup ale_hover_cursor
"  autocmd!
"  autocmd CursorHold * ALEHover
"augroup END

let g:context_menu_python = [
            \ ["Peek", "ALEHover"],
            \ ["Auto Import", ':call AutoPythonImport(expand("<cword>"))'],
            \ ["--", ],
            \ ["Rename", "ALERename"],
            \ ["Go To Definion", "ALEGoToDefinition"],
            \ ["--", ],
            \ ["Fix Issues", "ALEFix"],
            \ ["Open Terminal", "bel term"],
            \ ]

let g:ale_python_black_change_directory = 0

nnoremap <silent><leader>m :call quickui#tools#clever_context('m', g:context_menu_python, {})<cr>

let opts = {'w':600, 'h':800, 'callback':'TermExit'}
let opts.title = 'TIG POP'
nmap <silent> <leader>r :call quickui#terminal#open('/bin/bash', opts)<CR>

map w <Plug>CamelCaseMotion_w
map b <Plug>CamelCaseMotion_b
map e <Plug>CamelCaseMotion_e
