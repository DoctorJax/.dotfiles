"Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'dracula/vim',{'as':'dracula'}
Plug 'neoclide/coc.nvim', {'branch': 'release'} | Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-markdown' | Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim' | Plug 'vifm/vifm.vim' | Plug 'vimwiki/vimwiki'
Plug 'dense-analysis/ale'
call plug#end()

"General Settings
set encoding=UTF-8 splitbelow splitright nu wildmode=longest,full
set shiftwidth=4 autoindent smartindent tabstop=4 softtabstop=4 expandtab
set cursorline

"Key-bindings
let mapleader=" "
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>

nnoremap <leader>e :Explore<CR>
nnoremap <leader>p :CtrlP<CR>

nnoremap <leader><C-n> :set nofoldenable<CR>
nnoremap <leader><C-i> :set foldmethod=indent<CR>
nnoremap <leader><C-s> :set foldmethod=syntax<CR>

nnoremap Q <nop>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <S-t> :tabnew<CR>
nnoremap <S-Tab> :tabnext<CR>

"" My Status Line
"set statusline=
"set statusline+=%#DraculaTodo#
"set statusline+=\ %F\ 
"set statusline+=%r
"set statusline+=%m
"set statusline+=%#DraculaCyan#
"set statusline+=\ 
"set statusline+=%#NonText#
"set statusline+=%=
"set statusline+=%#DraculaPurple#
"set statusline+=\ 
"set statusline+=%#WildMenu#
"set statusline+=\ %y\ 
"set statusline+=%#DraculaPurple#
"set statusline+=
"set statusline+=%#DraculaSubtle#
"set statusline+=\ 
"set statusline+=%##
"set statusline+=\ %c:%l/%L 
"set statusline+=\ {%2p%%}

"Theme Settings
colorscheme dracula
set background=dark
set termguicolors

hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
