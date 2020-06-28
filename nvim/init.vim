" leader key = <space>
let mapleader=","
" Basic stuff
filetype plugin indent on
set nocompatible
set hidden
set termguicolors
set clipboard+=unnamedplus
set splitbelow splitright


" Trailing white spaces
autocmd BufWritePre * %s/\s\+$//e

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [
                \ 'coc-tsserver',
                \ 'coc-eslint',
                \ 'coc-css',
                \ 'coc-html',
                \ 'coc-prettier',
                \ 'coc-python',
                \ 'coc-snippets',
                \ 'coc-emmet',
                \ 'coc-pairs',
                \ 'coc-clangd',
                \ 'coc-terminal',
                \]
    Plug 'scrooloose/nerdtree'
    Plug 'itchyny/lightline.vim'
    Plug 'alvan/vim-closetag'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'tpope/vim-surround'
    Plug 'honza/vim-snippets'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'yggdroot/indentline'
    Plug 'morhetz/gruvbox'
    Plug 'sheerun/vim-polyglot'
    Plug 'terryma/vim-multiple-cursors'
call plug#end()

"Some more Basic
syntax on
set number relativenumber
set encoding=utf-8
set ignorecase
set smartcase

set nohlsearch
set nobackup
set nowb
set noswapfile

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

colorscheme gruvbox
hi Comment gui=italic

set cursorline cursorcolumn
 au WinLeave * set nocursorline nocursorcolumn
 au WinEnter * set cursorline cursorcolumn


" --------------------------
" --------------------------
" Neovim :Terminal
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert


" --------------------------
" --------------------------
" CoC Config
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes


inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" --------------------------
" --------------------------
" lightline
" get rid of --insert--
set noshowmode
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unnamed= '[No Name]'
 let g:lightline = {
       \ 'colorscheme': 'gruvbox',
       \ 'active': {
           \   'left': [ [ 'mode', 'paste' ],
           \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
           \ },
           \ 'component_function': {
           \   'gitbranch': 'FugitiveHead',
            \ 'cocstatus': 'coc#status',
           \ },
       \ }

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
set showtabline=2
let g:lightline.tabline = { 'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" ----------------------------------------
" --------------------------
" Enable spell checking, s for spell check
    map <C-s>s:setlocal spell! spelllang=en_au<CR>

" --------------------------
" --------------------------
" ctrlp
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*
    let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


" Uncomment to autostart the NERDTree
" autocmd vimenter * NERDTree
    map <A-m> :NERDTreeToggleVCS<CR>
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    let NERDTreeShowLineNumbers=1
    let NERDTreeShowHidden=1
    let NERDTreeMinimalUI = 1
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    let g:NERDTreeIgnore = ['^node_modules$', '^.git$']

" --------------------------
" --------------------------

" indent plugin stuff
    let g:indentLine_color_term = 239
    "let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    let g:indentLine_char_list = ['➜']

" --------------------------
" --------------------------
" Vim close tag


" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *,js, *.ts, *.jsx'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx, *js, *.ts'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml, js'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx, js'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'


" Keybindings
inoremap jk <esc>
vnoremap jk <esc>
tnoremap jk <C-\><C-n>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>


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
    inoremap <C-h> <C-\><C-N><C-w>h
    inoremap <C-j> <C-\><C-N><C-w>j
    inoremap <C-k> <C-\><C-N><C-w>k
    inoremap <C-l> <C-\><C-N><C-w>l
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l


nnoremap <C-t> :CocCommand terminal.Toggle<cr>
tnoremap <C-t> <C-\><C-n>:CocCommand terminal.Toggle<cr>
