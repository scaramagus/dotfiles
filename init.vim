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

    call minpac#add('neoclide/coc.nvim', {'branch': 'release', 'do': './install.sh'})

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
            \'\.pyc$', '\.pyo$', '__pycache__', 'node_modules', 'build$',
            \'dist$', '\.lock$', '\.ipython$', '\.mypy_cache$',
            \'\.pytest_cache$', '\.vscode$', '\.tern-port$',
            \'\.coverage$', '\.git$', '\.gitattributes$',
	    \'\.egg-info$', 'venv$', 'tags$', 'env$', '\.sqlite3$',
            \'\.o$',
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

" coc.nvim -----------------------------------
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_global_extensions = ['coc-explorer', 'coc-json', 'coc-tsserver', 'coc-tslint-plugin', 'coc-highlight', 'coc-snippets', 'coc-template', 'coc-html', 'coc-css', 'coc-emmet', 'coc-python', 'coc-phpls', 'coc-angular', 'coc-git']
let g:coc_global_extensions += ['https://github.com/andys8/vscode-jest-snippets']

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" vim-airline integration
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'E:'
let airline#extensions#coc#warning_symbol = 'W:'

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
set tabstop=4
set softtabstop=4
filetype plugin on
filetype indent on
highlight BadWhitespace ctermbg=red guibg=red
set hlsearch

" no temp or backup files
set noswapfile
set nobackup
set nowritebackup

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
