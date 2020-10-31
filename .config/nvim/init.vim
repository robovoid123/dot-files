"
    " Basic stuff
    let mapleader="\<Space>"
    filetype plugin indent on
    set nocompatible
    set hidden
    set termguicolors
    set clipboard+=unnamedplus
    set splitbelow splitright
"
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
        Plug 'itchyny/lightline.vim' " bottom part of lightline
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FZF
        Plug 'junegunn/fzf.vim' " Ctrl p but better
        Plug 'alvan/vim-closetag' " Closes tags
        Plug 'mengelbrecht/lightline-bufferline' " top part of lightline
        Plug 'tpope/vim-surround' " ysaw
        Plug 'honza/vim-snippets' " for snippets
        Plug 'ryanoasis/vim-devicons' " Icon packs
        Plug 'tpope/vim-commentary' " comment stuff out
        Plug 'tpope/vim-repeat' " Increase the . functionality
        Plug 'tpope/vim-fugitive' " Git wrapper
        Plug 'yggdroot/indentline' " Visual for indentation
        Plug 'joshdick/onedark.vim' " Vim theme
        Plug 'sheerun/vim-polyglot' " Language pack
        Plug 'vimwiki/vimwiki' " Vim note taking
        Plug 'dyng/ctrlsf.vim' " Quick way to edit multiple file
        Plug 'rrethy/vim-illuminate' " Highlights word currently under cursor
        Plug 'machakann/vim-highlightedyank' "Highlights the currently yanked section
        Plug 'edkolev/tmuxline.vim' "To generate tmuxline same as vim theme
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'tmhedberg/simpylfold' "Makes python folding bearable
        Plug 'tpope/vim-vinegar' "Enhances netrw
    call plug#end()
"
    "Some more Basic stuff
    syntax on
    set autoindent
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

    colorscheme onedark
    hi Comment gui=italic

    set cursorline cursorcolumn
    au WinLeave * set nocursorline nocursorcolumn
    au WinEnter * set cursorline cursorcolumn

    " Remove trailing whitespace on save
    autocmd BufWritePre * %s/\s\+$//e
"
    " Folding
    if has('folding')
    if has('windows')
        set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
    endif
    set foldmethod=indent               " not as cool as syntax, but faster
    set foldlevelstart=99
    endif
"
    " Netrw as a file explorer

    let g:netrw_liststyle = 1

    function! NetrwMappings()
        nnoremap <buffer> <C-l> <C-w>l
    endfunction

    augroup ProjectDrawer
        autocmd!
        autocmd filetype netrw call NetrwMappings()
    augroup END
"
    "tmuxline
    let g:tmuxline_powerline_separators = 0
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
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

    " Default fzf layout
    " - down / up / left / right
    let g:fzf_layout = { 'down': '~40%' }


    nnoremap // :BLines<CR>
    nnoremap ?? :Rg<CR>
    "
    " Enable file type detection.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Find files with fzf
    nmap <C-p> :Files<CR>
    nmap <leader>p :Commands<CR>
"
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
"
    " lightline
    " get rid of --insert--
    set noshowmode
    let g:lightline#bufferline#show_number  = 1
    let g:lightline#bufferline#enable_devicons = 1
    let g:lightline#bufferline#unnamed= '[No Name]'
    let g:lightline = {
        \ 'colorscheme': 'onedark',
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
    let g:indentLine_char_list = ['┃', '¦', '┆', '┊']
"
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

    let g:python3_host_prog = '/usr/bin/python3'
"
    " Key bindings
    inoremap jk <esc>
    vnoremap jk <esc>

    tnoremap jk <C-\><C-n>
    " Spell-check set to <leader>o, 'o' for 'orthography':
        nnoremap <leader>o :setlocal spell! spelllang=en_us<CR>
        nnoremap <leader>O  z=

    nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    nnoremap <leader>sv :source $MYVIMRC<cr>

    nnoremap <leader>v :vsplit<Return><C-w>w

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
