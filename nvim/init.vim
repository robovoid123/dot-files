" mapping leader current is space
let mapleader=" "

" Basic stuff
filetype plugin indent on
set nocompatible

syntax on
let python_highlight_all=1
set number relativenumber
set tabstop=2
set encoding=utf-8

set nohlsearch
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

colorscheme default
hi LineNr ctermfg=242
hi CursorLineNr ctermfg=15
hi VertSplit ctermfg=8 ctermbg=0
hi Statement ctermfg=3

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

    " vscode ctr p feature
    Plug 'ctrlpvim/ctrlp.vim'

    " tag completion and rename
    Plug 'alvan/vim-closetag'
    Plug 'AndrewRadev/tagalong.vim'

    Plug 'vim-scripts/indentpython.vim'

    " code suggestion
    Plug 'valloric/youcompleteme'

    " airline stuff
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'ryanoasis/vim-devicons'

    " surround feature
    Plug 'tpope/vim-surround'
    
    " Commenting
    Plug 'tpope/vim-commentary'
    
    " show indent
    Plug 'yggdroot/indentline'
    
    " nerd tree stuff
    Plug 'xuyuanp/nerdtree-git-plugin'
    Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    " check errors
    Plug 'scrooloose/syntastic'

call plug#end()

" Enable spell checking, s for spell check
    map <leader>s :setlocal spell! spelllang=en_au<CR>

" Uncomment to autostart the NERDTree
" autocmd vimenter * NERDTree
    map <C-n> :NERDTreeToggle<CR>
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    let NERDTreeShowLineNumbers=1
    let NERDTreeShowHidden=1
    let NERDTreeMinimalUI = 1


" Syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0

" Airline config
    let g:rehash256 = 1
    let g:Powerline_symbols='unicode'
    let g:Powerline_theme='long'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme='angr'


" indent plugin stuff
    let g:indentLine_color_term = 239
    "let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    let g:indentLine_char_list = ['➜']

" Keybindings
inoremap jk <esc>
vnoremap jk <esc>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

inoremap <esc> <nop>

" syntastic error close
noremap <C-z> :lclose<cr>

" Disable arrow keys in Normal mode
    no <Up> <Nop>
    no <Down> <Nop>
    no <Left> <Nop>
    no <Right> <Nop>

" Disable arrow keys in Insert mode
    ino <Up> <Nop>
    ino <Down> <Nop>
    ino <Left> <Nop>
    ino <Right> <Nop>

" Shortcutting split navigation, saving a keypress:
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

" Uppercase the current word
inoremap <C-u> <esc>viwUi
nnoremap <C-u> viwU<esc>

" Delete current line
inoremap <C-d> <esc>ddi
nnoremap <C-d> dd<esc>

" Saving file
nnoremap <leader>w :w
nnoremap <leader>q :q
nnoremap <leader>wq :wq

" Python Stuff
augroup pythonstuff:
    autocmd!
    autocmd Filetype python inoremap ;in def __init__(self<#>):<esc>/<#><ENTER>cf>
    autocmd Filetype python inoremap ;if if <#>:<esc>/<#><ENTER>cf>
    autocmd Filetype python inoremap ;el elif <#>:<esc>/<#><ENTER>cf>
    autocmd Filetype python inoremap ;p print(<#>)<esc>/<#><ENTER>cf>
    autocmd Filetype python inoremap ;q quit()
    autocmd Filetype python inoremap { {}<esc>i
    autocmd Filetype python inoremap [ []<esc>i
    autocmd Filetype python inoremap ( ()<esc>i

