" Fisa-nvim-config
" http://nvim.fisadev.com
" version: 10.0

" TODO current problems:
" * end key not working undef tmux+fish

function! PackInit() abort
    packadd minpac

    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Additional plugins here.

    call minpac#add('morhetz/gruvbox')

    " Override configs by directory
    call minpac#add('arielrossanigo/dir-configs-override.vim')

    " Code commenter
    call minpac#add('scrooloose/nerdcommenter')

    " Better file browser
    call minpac#add('scrooloose/nerdtree')

    " Class/module browser
    call minpac#add('majutsushi/tagbar')
    " TODO known problems:
    " * current block not refreshing

    " Search results counter
    call minpac#add('vim-scripts/IndexedSearch')

    " Airline
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('vim-airline/vim-airline-themes')

    call minpac#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })
    call minpac#add('junegunn/fzf.vim')

    " Pending tasks list
    call minpac#add('fisadev/FixedTaskList.vim')

    " Async autocompletion
    call minpac#add('Shougo/deoplete.nvim', {'do': 'UpdateRemotePlugins'})
    " Completion from other opened files
    call minpac#add('Shougo/context_filetype.vim')
    " Python autocompletion
    call minpac#add('zchee/deoplete-jedi', {'do': 'UpdateRemotePlugins'})
    " Just to add the python go-to-definition and similar features, autocompletion
    " from this call minpac#add(n is disabled)
    call minpac#add('davidhalter/jedi-vim')

    " Automatically close parenthesis, etc
    call minpac#add('Townk/vim-autoclose')

    " Surround
    call minpac#add('tpope/vim-surround')

    " Indent text object
    call minpac#add('michaeljsmith/vim-indent-object')

    " Indentation based movements
    call minpac#add('jeetsukumaran/vim-indentwise')

    " Better language packs
    call minpac#add('sheerun/vim-polyglot')

    " Ack code search (requires ack installed in the system)
    call minpac#add('mileszs/ack.vim')
    " TODO is there a way to prevent the progress which hides the editor?

    " Paint css colors with the real color
    call minpac#add('lilydjwg/colorizer')
    " TODO is there a better option for neovim?

    " Window chooser
    call minpac#add('t9md/vim-choosewin')

    " Automatically sort python imports
    call minpac#add('fisadev/vim-isort')

    " Highlight matching html tags
    call minpac#add('valloric/MatchTagAlways')

    " Generate html in a simple way
    call minpac#add('mattn/emmet-vim')

    " Git integration
    call minpac#add('tpope/vim-fugitive')

    " Git/mercurial/others diff icons on the side of the file lines
    call minpac#add('mhinz/vim-signify')

    " Yank history navigation
    call minpac#add('vim-scripts/YankRing.vim')

    " Linters
    call minpac#add('neomake/neomake', {'type': 'opt', 'do': 'Neomake'})
    call minpac#add('w0rp/ale')
    call minpac#add('myusuf3/numbers.vim')

    call minpac#add('blueyed/vim-diminactive')
    call minpac#add('ternjs/tern_for_vim')
    call minpac#add('carlitux/deoplete-ternjs')
    call minpac#add('benjie/local-npm-bin.vim')

    call minpac#add('christoomey/vim-tmux-navigator')
    call minpac#add('christoomey/vim-tmux-runner')

    call minpac#add('tiagofumo/vim-nerdtree-syntax-highlight')

    " Always load vim-devicons last!!!"
    call minpac#add('ryanoasis/vim-devicons')
endfunction

" Packages needed to load on startup (due to config modifications down below)
packadd neomake
packadd local-npm-bin.vim

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

" Disable checking for preprocessors (to avoid massive slow downs)
" let g:vue_disable_pre_processors=1

" Set python interpreter to editor's own virtualenv (to isolate dependencies)"
let g:python_host_prog = '/home/agustin/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/agustin/.pyenv/versions/neovim3/bin/python'

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" show line numbers
set nu

" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" Use true color "
set termguicolors

" Use 'gruvbox' dark color scheme "
colorscheme gruvbox
set background=dark

" Hide default bottom line (useless with airline) "
set noshowmode

" Show powerline symbols in status bar "
let g:airline_powerline_fonts=1

" Show relative linenumbers"
set number
set relativenumber

" Show invisible characters "
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" Move to start of line -> end of indent "
nmap 0 ^

" Splits navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" save as sudo
ca w!! w !sudo tee "%"

" tab navigation mappings
map tt :tabnew 
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__', 'node_modules']

" Open automatically if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close if the only open window is NERDTREE
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>

" Neomake ------------------------------

" Run linter on write
call neomake#configure#automake('w')

" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'
let g:neomake_javascript_enabled_makers = ['eslint']
let b:neomake_javascript_eslint_exe = GetNpmBin('eslint')
" Fzf ------------------------------

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tag<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" commands finder mapping
nmap ,c :Commands<CR>

" Deoplete -----------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:, 'deoplete#omni#input_patterns', {})
let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = [" — persistent"]

let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Ack.vim ------------------------------

" mappings
nmap ,r :Ack 
nmap ,wr :Ack <cword><CR>

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Yankring -------------------------------

" Fix for yankring and neovim problem when system has non-text things copied
" in clipboard
let g:yankring_clipboard_monitor = 0
let g:yankring_history_dir = '~/.config/nvim/'

" Airline ------------------------------
let g:airline#extensions#whitespace#enabled = 0

" Automatically rebalance windows on neovim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

syntax on
set autoindent
filetype plugin on
filetype indent on
highlight BadWhitespace ctermbg=red guibg=red
set hlsearch

" no temp or backup files
set noswapfile
set nobackup
set nowritebackup

" Yank to the system clipboard (requires the xsel system package)
set clipboard=unnamedplus

" File formats

" C
au BufRead,BufNewFile *.c,*.h set expandtab
au BufRead,BufNewFile *.c,*.h set tabstop=4
au BufRead,BufNewFile *.c,*.h set shiftwidth=4
au BufRead,BufNewFile *.c,*.h set autoindent
au BufRead,BufNewFile *.c,*.h match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.c,*.h match BadWhitespace /\s\+$/
au         BufNewFile *.c,*.h set fileformat=unix
au BufRead,BufNewFile *.c,*.h let b:comment_leader = '/* '

" Java
au BufRead,BufNewFile *.java set expandtab
au BufRead,BufNewFile *.java set tabstop=4
au BufRead,BufNewFile *.java set shiftwidth=4
au BufRead,BufNewFile *.java set autoindent
au BufRead,BufNewFile *.java match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.java match BadWhitespace /\s\+$/
au         BufNewFile *.java set fileformat=unix
au BufRead,BufNewFile *.java let b:comment_leader = '//'

" Python, PEP-008
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw set textwidth=139
au BufRead,BufNewFile *.py,*.pyw set tabstop=4
au BufRead,BufNewFile *.py,*.pyw set softtabstop=4
au BufRead,BufNewFile *.py,*.pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set autoindent
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/
au         BufNewFile *.py,*.pyw set fileformat=unix
au BufRead,BufNewFile *.py,*.pyw let b:comment_leader = '#'

" JS
au BufRead,BufNewFile *.js set expandtab
au BufRead,BufNewFile *.js set tabstop=2
au BufRead,BufNewFile *.js set softtabstop=2
au BufRead,BufNewFile *.js set shiftwidth=2
au BufRead,BufNewFile *.js set autoindent
au BufRead,BufNewFile *.js match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.js match BadWhitespace /\s\+$/
au         BufNewFile *.js set fileformat=unix
au BufRead,BufNewFile *.js let b:comment_leader = '//'

" Makefile
au BufRead,BufNewFile Makefile* set noexpandtab

" XML
au BufRead,BufNewFile *.xml set expandtab
au BufRead,BufNewFile *.xml set tabstop=4
au BufRead,BufNewFile *.xml set softtabstop=4
au BufRead,BufNewFile *.xml set shiftwidth=4
au BufRead,BufNewFile *.xml set autoindent
au BufRead,BufNewFile *.xml match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.xml match BadWhitespace /\s\+$/
au         BufNewFile *.xml set fileformat=unix
au BufRead,BufNewFile *.xml let b:comment_leader = '<!--'

" HTML
au BufRead,BufNewFile *.html set filetype=xml
au BufRead,BufNewFile *.html set expandtab
au BufRead,BufNewFile *.html set tabstop=2
au BufRead,BufNewFile *.html set softtabstop=2
au BufRead,BufNewFile *.html set shiftwidth=2
au BufRead,BufNewFile *.html set autoindent
au BufRead,BufNewFile *.html match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.html match BadWhitespace /\s\+$/
au         BufNewFile *.html set fileformat=unix
au BufRead,BufNewFile *.html let b:comment_leader = '<!--'

" Vue.js (*.vue)
au BufNewFile,BufRead *.vue set filetype=xml
au BufRead,BufNewFile *.vue set expandtab
au BufRead,BufNewFile *.vue set tabstop=2
au BufRead,BufNewFile *.vue set softtabstop=2
au BufRead,BufNewFile *.vue set shiftwidth=2
au BufRead,BufNewFile *.vue set autoindent
au BufRead,BufNewFile *.vue match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.vue match BadWhitespace /\s\+$/
au         BufNewFile *.vue set fileformat=unix

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
