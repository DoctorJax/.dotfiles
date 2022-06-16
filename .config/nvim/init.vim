"Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'neoclide/coc.nvim', {'branch': 'release'} | Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-markdown' | Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim' | Plug 'vifm/vifm.vim' | Plug 'vimwiki/vimwiki'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
call plug#end()

"General Settings
set encoding=UTF-8 splitbelow splitright nu wildmode=longest,list,full
set shiftwidth=4 autoindent smartindent tabstop=4 softtabstop=4 expandtab
set cursorline
set clipboard=unnamedplus
set mouse=a

"Vimwiki stuff
set nocompatible
filetype plugin on
syntax on
let g:vimwiki_ext2syntax = {}

"Key-bindings
let mapleader=" "
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>

nnoremap <leader>e :Explore<CR>
nnoremap <leader>p :CtrlP<CR>

nnoremap <leader><C-n> :set nofoldenable<CR>
nnoremap <leader><C-i> :set foldmethod=indent<CR>
nnoremap <leader><C-s> :set foldmethod=syntax<CR>
nnoremap <leader><C-m> :set foldmethod=marker<CR>
nnoremap <leader><C-f> :foldclose<CR>

nnoremap <leader>n :NERDTreeToggle<CR>

nnoremap <leader><S-s> :set spell<CR>

nnoremap Q <nop>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

nnoremap <C-l>h :tabr<CR>
nnoremap <C-l>l :tabl<CR>
nnoremap <C-l>j :tabp<CR>
nnoremap <C-l>k :tabn<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-x> :tabc<CR>

"Theme Settings
colorscheme tokyonight
set background=dark
set termguicolors

hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
