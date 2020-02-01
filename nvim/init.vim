let mapleader=","
" Basic stuff
set nocompatible
syntax on
set number relativenumber
set tabstop=2
set autoindent
set encoding=utf-8

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Specify a directory for plugins

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'morhetz/gruvbox'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'css',
    \ 'less',
    \ 'json',
    \ 'markdown',
    \ 'vue',
    \ 'php',
    \ 'python', 
    \ 'html'
    \ ] }


call plug#end()

 set termguicolors
 colorscheme gruvbox
 let g:gruvbox_bold =1
 let g:gruvbox_contrast_dark ='hard'


" Keybindings

inoremap ii <esc>
vnoremap ii <esc>
nnoremap ii i


nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
inoremap <esc> <nop>

noremap <UP> <nop>
noremap <DOWN> <nop>
noremap <LEFT> <nop>
noremap <RIGHT> <nop>
