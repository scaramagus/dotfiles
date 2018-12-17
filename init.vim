" Neovim configuration file "

call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'

Plug 'scrooloose/nerdtree'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'davidhalter/jedi-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Always load vim-devicons last!!!"
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Set python interpreter to editor's own virtualenv (to isolate dependencies)"
let g:python_host_prog = '/home/agustin/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/agustin/.pyenv/versions/neovim3/bin/python'

" Use true color "
set termguicolors

" Use 'gruvbox' dark color scheme "
colorscheme gruvbox
set background=dark

" Hide default bottom line (useless with airline) "
set noshowmode

" Show powerline symbols in status bar "
let g:airline_powerline_fonts=1

" Show linenumbers"
set number
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
