"Vim

let mapleader="\<Space>"

":PlugInstall to install plugins
call plug#begin('~/.vim/plugged')
    Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
    Plug 'mattn/emmet-vim' "autocomplet tags
    Plug 'itchyny/lightline.vim' "status bar
    Plug 'kshenoy/vim-signature' "view your marks
    Plug 'preservim/nerdtree'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
    Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
    Plug 'vim-scripts/AutoComplPop' "auto completion pops up automaticaly instead of <C-p>
    Plug 'preservim/nerdcommenter'
    Plug 'christoomey/vim-tmux-navigator' "tmux and vim window switcher BEST
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } "css colors
    Plug 'Yggdroot/indentLine' "show indent lines
    Plug 'https://github.com/ycm-core/YouCompleteMe.git'

    Plug 'https://github.com/jaredgorski/SpaceCamp'
    Plug 'NLKNguyen/papercolor-theme' "colorscheme
    Plug 'morhetz/gruvbox' "color scheme
call plug#end()

"Settings for plugins
    colorscheme gruvbox
    "colorscheme PaperColor
    "colorscheme spacecamp

    nnoremap gd :YcmCompleter GoTo<CR>
    let g:Hexokinase_highlighters = [ 'backgroundfull' ]

    let g:lightline = {
                \ 'active': {
                    \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified'] ],
                    \ }
                    \ }
    "for commenting. nerdcommenter toggle is <leader>c<Space>.
    map <leader>/ <space>c<space>

    let g:user_emmet_leader_key=','
    nnoremap <leader>n :NERDTreeFocus<CR>
    nnoremap <C-n> :NERDTree<CR>
    nnoremap <C-t> :NERDTreeToggle<CR>
    nnoremap <C-f> :NERDTreeFind<CR>
    "bookmark in NerdTree
    function! BookmarkDir()
        if exists("g:NERDTree") && g:NERDTree.IsOpen()
            :Bookmark
        else
            echo "NERDTree not Open"
        endif
    endfunction
    nnoremap <leader>b :call BookmarkDir()<CR>
"Done

"Basic Defaults
    "set list
    syntax enable
    set nocompatible
    set mouse=a
    set tabstop=4 softtabstop=4
    set shiftwidth=4
    set encoding=UTF-8
    set expandtab
    set smartindent
    set nu
    set relativenumber
    set nowrap
    set noswapfile
    set scrolloff=5
    set colorcolumn=80
    set laststatus=2
    set complete+=kspell
    set completeopt=menuone,longest
    set wildmode=list,full
    set background=dark
    set t_Co=256
    set foldmethod=indent
    set foldlevelstart=0
    "set nofoldenable "open folds when file open

    "better searching
    set incsearch
    "set hlsearch
    set ignorecase
    set smartcase
    nnoremap <CR> :nohlsearch<CR>
    set showcmd
    set wildmenu

    "set termguicolors
"Done

"Remapings
    inoremap jk <ESC>
    "make it easier to resize
    nnoremap <leader>h :wincmd <<CR>
    nnoremap <leader>j :wincmd +<CR>
    nnoremap <leader>k :wincmd -<CR>
    nnoremap <leader>l :wincmd ><CR>
    "yank till end of line
    nnoremap Y y$
    "Go to Begining of line
    nnoremap B 0
    "Go to end of line
    nnoremap E E$
    "replace words faster
    nnoremap <leader>r <Esc>yiw:%s/<C-R>"//gc<LEFT><LEFT><LEFT>
    vnoremap <leader>r yy:%s/<C-R>"//gc<LEFT><LEFT><LEFT>
    "complie and run code faster
    cnoremap ,cpp !g++ <C-r>%;./a.out 
    cnoremap ,py !python3 <C-r>%

    "open a new tab
    nnoremap <leader>t :tabnew<CR>:Ex<CR>

    nnoremap <leader>ev :vs $MYVIMRC<CR>
    nnoremap <leader>sv :w<cr>:source $MYVIMRC<CR>

    "If PUM (complete menu) is visible, then execute <C-y> (which selects an "item), otherwise regular tab
    inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"

    "starter templetes for files
    nnoremap ,cpp :r ~/.dotfiles/skeletons/cpp<CR>gg"_dd4j
    nnoremap ,html :r ~/.dotfiles/skeletons/html<CR>gg"_dd9j
    nnoremap ,java :r !bash ~/.dotfiles/skeletons/java.sh %<CR>gg"_dd2j

    "compare windows
    function! DiffWindo()
        if &diff
            :windo diffoff
        else
            if len(tabpagebuflist()) > 1
                :windo diffthis
            else
                :vs
                :Ex
            endif
        endif
    endfunction
    nnoremap <leader>d :call DiffWindo()<CR>
"Done Remapings

"Other Things
    "I like html files to only be indented by 2 spaces instead of normal 4
    autocmd FileType html,javascript set tabstop=2
    autocmd FileType html,javascript set softtabstop=2
    autocmd FileType html,javascript set shiftwidth=2
    "c++ formating :help cinoptions-values 
    autocmd FileType cpp set cinoptions=l1 

    "for highlighting Yanked Text
    function! DeleteTemporaryMatch(timerId)
        call matchdelete(g:idTemporaryHighlight)
    endfunction

    function! FlashYankedText()
        let g:idTemporaryHighlight = matchadd('IncSearch', ".\\%>'\\[\\_.*\\%<']..")
        call timer_start(50,"DeleteTemporaryMatch")
    endfunction

    augroup highlightYankedText
        autocmd!
        autocmd TextYankPost * call FlashYankedText()
    augroup END


    " Reference chart of values:
    "   Ps = 0  -> blinking block.
    "   Ps = 1  -> blinking block (default).
    "   Ps = 2  -> steady block.
    "   Ps = 3  -> blinking underline.
    "   Ps = 4  -> steady underline.
    "   Ps = 5  -> blinking bar (xterm).
    "   Ps = 6  -> steady bar (xterm).
    "let &t_SI = "\e[5 q"
    "let &t_EI = "\e[1 q"

    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
    else
        let &t_SI = "\e[5 q"
        let &t_EI = "\e[2 q"
    endif



    "WSL yank support
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' |call system(s:clip, @0) | endif
        augroup END
    endif
