"Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'dracula/vim',{'as':'dracula'}
Plug 'neoclide/coc.nvim', {'branch': 'release'} | Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-markdown' | Plug 'ap/vim-css-color'

call plug#end()

"General Settings
set encoding=UTF-8 splitbelow splitright nu wildmode=longest,full
set shiftwidth=4 autoindent smartindent tabstop=4 softtabstop=4 expandtab

"Key-bindings
let mapleader=" "
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>

nnoremap <leader>e :Explore<CR>
nnoremap <leader>p :CtrlP<CR>

nnoremap <leader><C-l> :set nofoldenable<CR>
nnoremap <C-l> :set foldmethod=indent<CR>
nnoremap <C-k> :set foldmethod=syntax<CR>

nnoremap Q <nop>

"Status Line
set statusline=
set statusline+=%#DraculaTodo#
set statusline+=\ %F\ 
set statusline+=%r
set statusline+=%m
set statusline+=%#NonText#
set statusline+=%=
set statusline+=%#WildMenu#
set statusline+=\ %y\ 
set statusline+=%##
set statusline+=\ %l,%c 
set statusline+=\ {%2p%%}

"Theme Settings
colorscheme dracula
set background=dark
set termguicolors

hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
