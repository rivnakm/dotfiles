call plug#begin(stdpath('data') . '/plugged')

Plug 'dracula/vim', {'as': 'dracula'}
" Plug 'itchyny/lightline.vim'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'preservim/nerdtree'

call plug#end()

set ts=4 sw=4
syntax on

" Set colorscheme
colorscheme dracula

" Set backgrounds to transparent
hi Normal guibg=NONE ctermbg=NONE
hi StatusLine guibg=NONE ctermfg=0 ctermbg=6
hi StatusLineNC guibg=NONE ctermfg=6 ctermbg=NONE

" let g:lightline = {'colorscheme': 'dracula'}

" Open NERDTree when no directory specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NERDTree
map <C-n> :NERDTreeToggle<CR>

" New bindings to switch between panels
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
