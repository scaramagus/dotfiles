" Based on fisa-nvim-config
" http://nvim.fisadev.com


function! PackInit() abort
    packadd minpac

    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Additional plugins here.

    " Gruvbox color scheme
    call minpac#add('morhetz/gruvbox')

    " Code commenter
    call minpac#add('tpope/vim-commentary')

    " Better file browser
    call minpac#add('scrooloose/nerdtree')
    call minpac#add('tiagofumo/vim-nerdtree-syntax-highlight')

    " Class/module browser
    call minpac#add('majutsushi/tagbar')

    " Search results counter
    call minpac#add('vim-scripts/IndexedSearch')

    " Adjust tab settings based on current file
    call minpac#add('tpope/vim-sleuth')

    " Airline
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('vim-airline/vim-airline-themes')

    call minpac#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })
    call minpac#add('junegunn/fzf.vim')

    " Pending tasks list
    call minpac#add('fisadev/FixedTaskList.vim')

    " Automatically close parenthesis, etc
    call minpac#add('jiangmiao/auto-pairs')

    " Surround
    call minpac#add('tpope/vim-surround')

    " Indent text object
    call minpac#add('michaeljsmith/vim-indent-object')

    " Indentation based movements
    call minpac#add('jeetsukumaran/vim-indentwise')

    " Better f-t mappings
    call minpac#add('rhysd/clever-f.vim')

    " Add more text objects for targets
    call minpac#add('wellle/targets.vim')

    " Better language packs
    call minpac#add('sheerun/vim-polyglot')
    call minpac#add('ekalinin/Dockerfile.vim')

    " Ack code search (requires ack installed in the system)
    call minpac#add('mileszs/ack.vim')

    " Paint css colors with the real color
    call minpac#add('lilydjwg/colorizer')

    " Window chooser
    call minpac#add('t9md/vim-choosewin')

    " Highlight matching html tags
    call minpac#add('valloric/MatchTagAlways')

    " Generate html in a simple way
    call minpac#add('mattn/emmet-vim')

    " Git integration
    call minpac#add('tpope/vim-fugitive')

    " Git/mercurial/others diff icons on the side of the file lines
    call minpac#add('mhinz/vim-signify')

    " Yank history navigation
    call minpac#add('bfredl/nvim-miniyank')

    call minpac#add('myusuf3/numbers.vim')

    call minpac#add('blueyed/vim-diminactive')
    call minpac#add('benjie/local-npm-bin.vim')

    call minpac#add('christoomey/vim-tmux-navigator')
    call minpac#add('christoomey/vim-tmux-runner')

    call minpac#add('w0rp/ale')

    " Always load vim-devicons last!!!"
    call minpac#add('ryanoasis/vim-devicons')
endfunction

" Packages needed to load on startup (due to config modifications down below)
packadd local-npm-bin.vim

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

" Set python interpreter to editor's own virtualenv (to isolate dependencies)"
let g:python_host_prog = '/home/agustin/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/agustin/.pyenv/versions/neovim3/bin/python'

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

"This unsets the last search pattern register by hitting return
nnoremap <CR> :noh<CR><CR>

" remove ugly vertical lines on window division
set fillchars+=vert:\

" Use true color "
set termguicolors

" Use 'gruvbox' dark color scheme "
colorscheme gruvbox
set background=dark

" Hide default bottom line (useless with airline) "
set noshowmode

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
nmap ,<F3> :NERDTreeFind<CR>

" Show hidden files
let NERDTreeShowHidden = 1

" don;t show these file types
let NERDTreeIgnore = [
            \'\.pyc$', '\.pyo$', '__pycache__', 'node_modules',
            \'dist', '\.lock$', '\.ipython$', '\.mypy_cache$',
            \'\.pytest_cache$', '\.vscode$', '\.tern-port$',
            \'\.coverage$', '\.git$', '\.gitattributes$',
	    \'\.egg-info$', 'venv$', 'tags$', 'env$', '\.sqlite3$'
            \]

" Open automatically if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close if the only open window is NERDTREE
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Enable folder icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" Fix directory colors
highlight! link NERDTreeFlags NERDTreeDir

" Remove expandable arrow
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()
" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>

" Fzf ------------------------------

" file finder mapping
nmap ,f :Files<CR>

" tags (symbols) in current file finder mapping
nmap ,T :BTag<CR>
" tags (symbols) in all files finder mapping
nmap ,t :Tags<CR>

" general code finder in current file mapping
nmap ,L :BLines<CR>
" general code finder in all files mapping
nmap ,l :Lines<CR>

" commands finder mapping
nmap ,c :Commands<CR>

" recursive grep
nmap ,a :Ag<CR>
" recursive grep current word
nmap ,w :Ag <C-R><C-W><CR>

" ALE ------------------------
" Enable autocompletion (must be set before loading ALE)
let g:ale_completion_enabled = 1
packadd ale

" Set symbols
let g:ale_sign_error = ''
let g:ale_sign_warning = '⚠'

" Define linters
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \'python': ['pyls', 'flake8', 'pylint', 'mypy', 'isort'],
            \'javascript': ['eslint'],
            \}

" Define fixers
let g:ale_fixers = {
            \'*': ['remove_trailing_lines', 'trim_whitespace'],
            \}
let g:ale_fix_on_save = 1

" Error message format
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%linter%] %s'

"" Go to definition in new split
nmap ,D :ALEGoToDefinitionInSplit<CR>

" vim-airline --------------------------

" Show errors in status bar
let g:airline#extensions#ale#enabled = 1

" Show powerline symbols in status bar "
let g:airline_powerline_fonts=1

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)

" show big letters
let g:choosewin_overlay_enable = 1

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
let g:signify_vcs_list = ['git']

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

" nvim-miniyank ------------------------
set clipboard=unnamedplus

map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

map <leader>p <Plug>(miniyank-startput)
map <leader>P <Plug>(miniyank-startPut)
map <leader>n <Plug>(miniyank-cycle)
map <leader>N <Plug>(miniyank-cycleback)

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

" JSON
au BufRead,BufNewFile *.json set expandtab
au BufRead,BufNewFile *.json set tabstop=4
au BufRead,BufNewFile *.json set softtabstop=4
au BufRead,BufNewFile *.json set shiftwidth=4
au BufRead,BufNewFile *.json set autoindent
au BufRead,BufNewFile *.json match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.json match BadWhitespace /\s\+$/
au         BufNewFile *.json set fileformat=unix

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
au BufRead,BufNewFile *.html set filetype=html
au BufRead,BufNewFile *.html set expandtab
au BufRead,BufNewFile *.html set tabstop=4
au BufRead,BufNewFile *.html set softtabstop=4
au BufRead,BufNewFile *.html set shiftwidth=4
au BufRead,BufNewFile *.html set autoindent
au BufRead,BufNewFile *.html match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.html match BadWhitespace /\s\+$/
au         BufNewFile *.html set fileformat=unix
au BufRead,BufNewFile *.html let b:comment_leader = '<!--'

" Vue
au BufRead,BufNewFile *.vue set filetype=html
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
