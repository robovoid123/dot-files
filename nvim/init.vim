" mapping leader current is space
let mapleader=" "

" Basic stuff
filetype plugin indent on
set nocompatible
set hidden
set termguicolors

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

    " vscode ctr p feature
    Plug 'ctrlpvim/ctrlp.vim'

    " gruvbox colorscheme
    Plug 'morhetz/gruvbox'
   
    " color preview
    Plug 'RRethy/vim-hexokinase'

    " git plugin
    Plug 'tpope/vim-fugitive'

    " tag completion and rename
    Plug 'alvan/vim-closetag'
    Plug 'AndrewRadev/tagalong.vim'

    " code suggestion
    Plug 'valloric/youcompleteme'


    Plug 'ryanoasis/vim-devicons'

    " surround feature
    Plug 'tpope/vim-surround'

    " Auto pair brackets and stuff
    Plug 'jiangmiao/auto-pairs'
    
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

    " Emmet like vscode
    Plug 'mattn/emmet-vim'
    
    " status bar
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'


call plug#end()


syntax on
let python_highlight_all=1
set number relativenumber
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

" gruvbox config
let g:gruvbox_contrast_dark = 'hard'

" lightline
" get rid of --insert--
set noshowmode
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unnamed= '[No Name]'
 let g:lightline = {
       \ 'colorscheme': 'seoul256',
       \ 'active': {
           \   'left': [ [ 'mode', 'paste' ],
           \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
           \ },
           \ 'component_function': {
           \   'gitbranch': 'FugitiveHead'
           \ },
       \ }
set showtabline=2
let g:lightline.tabline = { 'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

colorscheme gruvbox

" Enable spell checking, s for spell check
    map <leader>s :setlocal spell! spelllang=en_au<CR>

" ctrlp
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*
    let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
    
" Uncomment to autostart the NERDTree
" autocmd vimenter * NERDTree
    map <C-n> :NERDTreeToggleVCS<CR>
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    let NERDTreeShowLineNumbers=1
    let NERDTreeShowHidden=1
    let NERDTreeMinimalUI = 1

    let g:NERDTreeIgnore = ['^node_modules$', '^.git$']


" Syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0

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

" Python Stuff
" augroup pythonstuff:
"     autocmd!
"     autocmd Filetype python inoremap ;in def __init__(self<#>):<esc>/<#><ENTER>cf>
"     autocmd Filetype python inoremap ;if if <#>:<esc>/<#><ENTER>cf>
"     autocmd Filetype python inoremap ;el elif <#>:<esc>/<#><ENTER>cf>
"     autocmd Filetype python inoremap ;p print(<#>)<esc>/<#><ENTER>cf>
"     autocmd Filetype python inoremap ;q quit()
" 
