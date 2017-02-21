set nocompatible              " be iMproved, required
filetype off                  " required

"=====================================================
" Vundle settings
"=====================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'  " let Vundle manage Vundle, required

"---------=== Code/project navigation ===-------------
Plugin 'scrooloose/nerdtree'          " Project and file navigation
Plugin 'Shougo/unite.vim'             " Navigation between buffers and files
Plugin 'majutsushi/tagbar'            " Class/module browser
Plugin 'valloric/youcompleteme'       " Code completion
Plugin 'airblade/vim-gitgutter'       " Git change
Plugin 'scrooloose/syntastic'         " Syntax checker

"--------------=== Snippets support ===---------------
Plugin 'garbas/vim-snipmate'            " Snippets manager
Plugin 'MarcWeber/vim-addon-mw-utils'   " dependencies #1
Plugin 'tomtom/tlib_vim'                " dependencies #2
Plugin 'honza/vim-snippets'             " snippets repo

"---------------=== Languages support ===-------------

" --- Python ---
Plugin 'davidhalter/jedi-vim'           " Awesome Python autocompletion with VIM
Plugin 'klen/python-mode'               " Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box
Plugin 'mitsuhiko/vim-jinja'            " Jinja support for vim
Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim
Plugin 'hynek/vim-python-pep8-indent'   " PEP8 indent
Plugin 'jmcantrell/vim-virtualenv'      " Virtualenv support in VIM

" --- RUST ---
Plugin 'rust-lang/rust.vim'

"------------------=== Other ===----------------------
Plugin 'bling/vim-airline'               " Lean & mean status/tabline for vim
Plugin 'fisadev/FixedTaskList.vim'       " Pending tasks list
Plugin 'rosenfeld/conque-term'           " Consoles as buffers
Plugin 'tpope/vim-surround'              " Parentheses, brackets, quotes, XML tags, and more
Plugin 'nathanaelkane/vim-indent-guides' " A Vim plugin for visually displaying indent levels in code
Plugin 'tomasr/molokai'

call vundle#end()              " required
filetype on
filetype plugin on
filetype plugin indent on

"=====================================================
" General settings
"=====================================================
set backspace=indent,eol,start
"let no_buffers_menu=1
set mousemodel=popup

set ruler
set completeopt-=preview
set gcr=a:blinkon0
if has("gui_running")
  set cursorline
endif
set ttyfast

syntax on " включить подсветку кода

colorscheme molokai
let g:molokai_original = 1

if has("gui_running")
" GUI? устаналиваем тему и размер окна
  set lines=50 columns=125

" set guifont=h12
" раскомментируйте эти строки, если хотите,
" чтобы NERDTree/TagBar автоматически отображались при запуске vim
" autocmd vimenter * TagbarToggle
" autocmd vimenter * NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif

" на маке vim?
if has("mac")
  set guifont=Consolas:h13
  set fuoptions=maxvert,maxhorz
else
" дефолтный GUI
  set guifont=Monospace\ Regular\ 12
endif
endif

tab sball
set switchbuf=useopen
set clipboard=unnamedplus " Use system clipboard

" отключаем пищалку и мигание
set visualbell t_vb=
set novisualbell

set enc=utf-8      " utf-8 по дефолту в файлах
set ls=2           " всегда показываем статусбар
set incsearch      " инкреминтируемый поиск
set hlsearch       " подсветка результатов поиска
set nu             " показывать номера строк
set scrolloff=5    " 5 строк при скролле за раз

" отключаем бэкапы и своп-файлы
"set nobackup         " no backup files
"set nowritebackup    " only in case you don't want a backup file while editing
"set noswapfile       " no swap files

" прячем панельки
"set guioptions-=m    " меню
"set guioptions-=T    " тулбар
"set guioptions-=r    " скроллбары

" настройка на Tab
set smarttab
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

"  при переходе за границу в 80 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
augroup vimrc_autocmds
    autocmd!
    autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
    autocmd FileType ruby,python,javascript,c,cpp set nowrap
augroup END

" указываем каталог с настройками SnipMate
let g:snippets_dir = "~/.vim/vim-snippets/snippets"

" настройки Vim-Airline
set laststatus=2
let g:airline_theme='dark'
let g:airline_left_sep='>'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" TagBar настройки
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0 " автофокус на Tagbar при открытии


" NerdTree настройки
" показать NERDTree на F1
map <F1> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']  "игноррируемые файлы с расширениями

" Unite settings
" browse a list of the currently opened buffers
nnoremap <F2> :Unite buffer<CR>

" TaskList настройки
" отобразить список тасков на F3
map <F3> :TaskList<CR>

" Работа буфферами
" CTRL+Q - закрыть текущий буффер
map <C-q> :bd<CR>

"=====================================================
" Python-mode settings
"=====================================================
" отключаем автокомплит по коду (у нас вместо него используется jedi-vim)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" документация
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'

" проверка кода
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110"
let g:pymode_lint_write = 1 " провека кода после сохранения

let g:pymode_virtualenv = 1 " поддержка virtualenv

let g:pymode_breakpoint = 1 " установка breakpoints
let g:pymode_breakpoint_key = '<leader>b'

" подстветка синтаксиса
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

let g:pymode_folding = 0 " отключить autofold по коду

let g:pymode_run = 0     " возможность запускать код

" Disable choose first function/method at autocomplete
let g:jedi#popup_select_first = 0

"=====================================================
" User hotkeys
"=====================================================
" ConqueTerm
" запуск интерпретатора на F5
nnoremap <F5> :ConqueTermSplit ipython<CR>
" а debug-mode на <F6>
nnoremap <F6> :exe "ConqueTermSplit ipython " . expand("%")<CR>
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 0
" проверка кода в соответствии с PEP8 через <leader>8
autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>

" автокомплит через <Ctrl+Space>
inoremap <C-space> <C-x><C-o>

" переключение между синтаксисами
nnoremap <leader>Th :set ft=htmljinja<CR>
nnoremap <leader>Tp :set ft=python<CR>
nnoremap <leader>Tj :set ft=javascript<CR>
nnoremap <leader>Tc :set ft=css<CR>
nnoremap <leader>Td :set ft=django<CR>

"=====================================================
" Languages support
"=====================================================
" --- Python ---
"autocmd FileType python set completeopt-=preview " раскомментируйте, в случае, если не надо, чтобы jedi-vim показывал документацию по методу/классу
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" --- JavaScript ---
let javascript_enable_domhtmlcss=1
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd BufNewFile,BufRead *.json setlocal ft=javascript

" --- HTML ---
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" --- template language support (SGML / XML too) ---
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd bufnewfile,bufread *.rhtml setlocal ft=eruby
autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
let html_no_rendering=1
let g:closetag_default_xml=1
let g:sparkupNextMapping='<c-l>'
autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1

" --- CSS ---
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

set keymap=russian-jcuken
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

set nowrap " чтобы строки не переносились
let bsl_fold = 1


"let g:tagbar_ctags_bin = '~/bin/universal-ctags/bin/ctags'
