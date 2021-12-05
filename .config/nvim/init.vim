"
    " Basic stuff
    let mapleader=","
    filetype plugin indent on
    set nocompatible
    set hidden
    set termguicolors
    set clipboard+=unnamedplus
    set splitbelow splitright

    " Auto indent pasted text
    nnoremap p p=`]<C-o>
    nnoremap P P=`]<C-o>


    " Vim Plug plugin manager
    call plug#begin('~/.vim/plugged')
        Plug 'neoclide/coc.nvim', {'branch': 'release'} "Completion engine
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
                    \]
        Plug 'mg979/vim-visual-multi'
        Plug 'itchyny/lightline.vim' " bottom part of lightline
        Plug 'yuttie/comfortable-motion.vim'
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FZF
        Plug 'junegunn/fzf.vim'
        Plug 'mengelbrecht/lightline-bufferline' " top part of lightline
        Plug 'tpope/vim-surround' " ysaw
        Plug 'honza/vim-snippets' " for snippets
        Plug 'ryanoasis/vim-devicons' " Icon packs
        Plug 'tpope/vim-commentary' " comment stuff out
        Plug 'tpope/vim-repeat' " Increase the . functionality
        Plug 'tpope/vim-fugitive' " Git wrapper
        Plug 'scrooloose/nerdtree' "nerdtree
        Plug 'xuyuanp/nerdtree-git-plugin'
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
        Plug 'yggdroot/indentline' " Visual for indentation
        Plug 'vimwiki/vimwiki' " Vim note taking
        Plug 'dyng/ctrlsf.vim' " Quick way to edit multiple file
        Plug 'machakann/vim-highlightedyank' "Highlights the currently yanked section
        Plug 'dracula/vim', { 'as': 'dracula' }
        Plug 'christoomey/vim-tmux-navigator'
        call plug#end()


    "Some more Basic stuff
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
    set shiftround

    set spelllang=en_us

    colorscheme dracula



    set cursorline cursorcolumn
    au WinLeave * set nocursorline nocursorcolumn
    au WinEnter * set cursorline cursorcolumn

    " Remove trailing whitespace on save
    autocmd BufWritePre * %s/\s\+$//e
"

"
    " NerdTree
        map <C-n> :NERDTreeToggle<CR>
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
        let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
        let g:NERDTreeLimitedSyntax = 1
"
    " ctrlsf
    nmap <leader>a :CtrlSF -R ""<Left>
    nmap <leader>A <Plug>CtrlSFCwordPath -W<CR>
    nmap <leader>c :CtrlSFFocus<CR>
    nmap <leader>C :CtrlSFToggle<CR>

    let g:ctrlsf_winsize = '33%'
    let g:ctrlsf_auto_close = 0
    let g:ctrlsf_confirm_save = 0
    let g:ctrlsf_auto_focus = {
        \ 'at': 'start',
        \ }
"
    " fzf
        let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules, vendor}/*"'

        command! -bang -nargs=? -complete=dir Files
                    \call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

        " Default fzf layout
        " - down / up / left / right
        let g:fzf_layout = {
                    \'window': {
                    \'width': 0.9,
                    \'height': 0.8,
                    \}
                    \}

        let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"


        " Find files with fzf
        nmap <C-p> :Files<CR>
        nmap <leader>p :Commands<CR>
 "
    " CoC Config
    set cmdheight=1
    set updatetime=300
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
    else
    set signcolumn=yes
    endif


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

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    " Show commands.
    nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>
    " Use <leader>cs for trigger snippet expand.
    imap <leader>cs <Plug>(coc-snippets-expand)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
"
    " lightline
    " get rid of --insert--
    set noshowmode
    let g:lightline#bufferline#show_number  = 2
    let g:lightline#bufferline#enable_devicons = 1
    let g:lightline#bufferline#unnamed= '[No Name]'
    let g:lightline = {
        \ 'colorscheme': 'dracula',
        \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             ['cocstatus', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
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
"
    " indent plugin stuff
    let g:indentLine_color_term = 239
    let g:indentLine_char_list = ['➜']


"
    " Spell-check set to <leader>o, 'o' for 'orthography':
    nnoremap <leader>o :setlocal spell! spelllang=en_us<CR>
    nnoremap <leader>O  z=
"
    "vimwiki
    " let g:vimwiki_list = [{'path': '~/vimwiki/',
    "                     \ 'syntax': 'markdown', 'ext': '.md'}]
"
" Key bindings
"
        inoremap jk <esc>
        vnoremap jk <esc>
        tnoremap jk <C-\><C-n>


        nnoremap <leader>ev :edit $MYVIMRC<cr>
        nnoremap <leader>sv :source $MYVIMRC<cr>

        nnoremap <leader>v :vsplit<cr><C-w>w
        nnoremap <leader>V :split<cr><C-w>j

        nmap <C-_> <Plug>Commentary
        xmap <C-_> <Plug>Commentary
        omap <C-_> <Plug>Commentary

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

    " Shortcutting split navigation, saving a key press:
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

