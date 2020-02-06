set mouse=a
set expandtab
set textwidth=79
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set background=dark
set modeline
set foldmethod=indent
set foldlevel=99
set colorcolumn=79
set number

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
filetype on
syntax on
runtime macros/matchit.vim

nnoremap <leader>v <Plug>TaskList
map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
let g:pep8_map='<leader>8'

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

nmap <leader>a <Esc>:Ack!

"%{fugitive#statusline()}

" Powerline settings
map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2
" Use 256 colours (only if your terminal supports it)
set t_Co=256

let g:gitgutter_enabled=1
if exists('&signcolumn')  " VIM 7.4.2201
  set signcolumn=yes
else
    let g:gitgutter_sign_volumn_always = 1
endif
set showcmd

set runtimepath^=~/.vim/bundle/ctrlp.vim

" ropevim settings
" https://github.com/python-rope/ropevim
" let ropevim_vim_completion=1

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

au VimEnter * RainbowParenthesesToggle


let g:pymode_rope_regenerate_on_write = 0

"autopep8
let g:autopep8_disable_show_diff=1
let g:autopep8_ignore=""
let g:autopep8_max_line_length=79

if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif

if &shell =~# 'fish$'
    set shell=sh
endif

autocmd BufEnter /hammer/ set et | let g:syntastic_python_checkers=["flake8"] | let g:syntastic_python_pyflakes_exec="pyflakes3" | let g:syntastic_python_flake8_exec="python3" | let g:syntastic_python_flake8_args=["-m", "flake8", "--max-line-length=120", "--ignore=E402,E741"]

autocmd BufEnter /cinder/ let g:syntastic_python_checkers=['flake8'] | let g:syntastic_python_flake8_exec='.tox/pep8/bin/flake8'
