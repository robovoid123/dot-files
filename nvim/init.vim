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
    " quick search file
    Plug 'ctrlpvim/ctrlp.vim'

    " vim-prettier
    " formats codes in better way
    Plug 'prettier/vim-prettier', {
          \ 'do': 'yarn install',
          \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'react', 'yaml', 'html'] }

    " gruvbox colorscheme
    Plug 'morhetz/gruvbox'
   
    " color preview
    Plug 'RRethy/vim-hexokinase'

    " git plugin
    Plug 'tpope/vim-fugitive'
    " gutter to tell me 
    " what was modified and so on..
    Plug 'airblade/vim-gitgutter'

    " tag completion and rename
    " completes html tag
    Plug 'alvan/vim-closetag'
    " updates the tag if i change on of the tag
    Plug 'AndrewRadev/tagalong.vim'

    " code suggestion
    " extension i am using
    " coc-python
    " coc-eslint
    " coc-tsserver
    " coc-css
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " icons in nerd tree and bufferline
    Plug 'ryanoasis/vim-devicons'

    " surround feature
    " ys and cs to change the add surroundings
    Plug 'tpope/vim-surround'

    " Auto pair brackets and stuff
    Plug 'jiangmiao/auto-pairs'
    
    " Commenting
    Plug 'tpope/vim-commentary'
    
    " show indent line ->
    Plug 'yggdroot/indentline'
    
    " nerd tree stuff
    Plug 'xuyuanp/nerdtree-git-plugin'
    Plug 'scrooloose/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    " check errors
    " async linting
    Plug 'w0rp/ale'

    " Emmet like vscode
    " html:5 <C-y>
    Plug 'mattn/emmet-vim'
    
    " status line
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'

    " snippets
    " this one is snippet engine
    Plug 'sirver/ultisnips'
    " this is the collection of snippets
    Plug 'honza/vim-snippets'

    " on language pack to rule them all
    " this one is for syntax highlight
    Plug 'sheerun/vim-polyglot'



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

let g:ale_set_balloons = 1

" CoC config
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" gruvbox config
let g:gruvbox_contrast_dark = 'medium'

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

colorscheme gruvbox

" Enable spell checking, s for spell check
    map <C-s>s:setlocal spell! spelllang=en_au<CR>

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
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    let g:NERDTreeIgnore = ['^node_modules$', '^.git$']


" indent plugin stuff
    let g:indentLine_color_term = 239
    "let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    let g:indentLine_char_list = ['➜']

" snippets config
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-q>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" prettier
let g:prettier#exec_cmd_async = 1
" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

" hexokinase color preview
let g:Hexokinase_highlighters = ['backgroundfull']

" Keybindings
inoremap jk <esc>
vnoremap jk <esc>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

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
