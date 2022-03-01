"Neo Vim

let mapleader="\<Space>"

":PlugInstall to install plugins
call plug#begin('~/.vim/plugged')
    Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
    Plug 'mattn/emmet-vim' "autocomplet tags
    Plug 'itchyny/lightline.vim' "status bar
    Plug 'nvim-lua/plenary.nvim' "for telescope.nvim
    Plug 'nvim-telescope/telescope.nvim' "fuzzy finding
    Plug 'kshenoy/vim-signature' "view your marks
    Plug 'preservim/nerdtree'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
    Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
    Plug 'vim-scripts/AutoComplPop' "auto completion pops up automaticaly instead of <C-p>
    Plug 'preservim/nerdcommenter'
    Plug 'christoomey/vim-tmux-navigator' "tmux and vim window switcher BEST
    Plug 'jiangmiao/auto-pairs' "completes bracket pairs
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } "css colors
    Plug 'Yggdroot/indentLine' "show indent lines
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'https://github.com/jaredgorski/SpaceCamp'
    Plug 'NLKNguyen/papercolor-theme' "colorscheme
    Plug 'morhetz/gruvbox' "color scheme
call plug#end()

    
colorscheme PaperColor
"Settings for plugins
    "colorscheme gruvbox
    colorscheme PaperColor
    "colorscheme spacecamp

    " Find files using Telescope command-line sugar.
    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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
    syntax enable
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
    "set scrolloff=5
    set colorcolumn=80
    set laststatus=2
    set complete+=kspell
    set completeopt=menuone,longest
    set wildmode=list,full
    set omnifunc=syntaxcomplete#complete
    "set background=dark
    "set t_Co=256
    set foldmethod=indent
    "set nofoldenable "open folds when file open

    "better searching
    set incsearch
    "set hlsearch
    set ignorecase
    "set smartcase
    nnoremap <CR> :nohlsearch<CR>
    set showcmd
    set wildmenu
"Done

"Remapings
    inoremap jk <ESC>
    "make it easier to resize
    nnoremap <leader>h :wincmd <<CR>
    nnoremap <leader>j :wincmd +<CR>
    nnoremap <leader>k :wincmd -<CR>
    nnoremap <leader>l :wincmd ><CR>
    "make a split into a tab BUT keep the split in the other tab
    nnoremap <C-w>t :tabnew %<CR>
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

    nnoremap <leader>ev :vs ~/.dotfiles/init.vim<CR>
    nnoremap <leader>sv :w<cr>:source ~/.dotfiles/init.vim<CR>

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

    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
    augroup END

    if has('nvim')
        "" Use Alt + ; to go to normal mode
        tnoremap <A-;> <C-\><C-n>
        "" Use Alt + Shift + ; to go to command mode
        tnoremap <A-:> <C-\><C-n>:
        "" Open new terminals in splits
        "cabbrev term <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'split term://bash' : 'term')<CR>
        "cabbrev vterm <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vsplit term://bash' : 'vterm')<CR>
        augroup term_cmds
            autocmd!
            "" Bypass normal mode when changing focus to terminal buffer
            autocmd BufWinEnter,WinEnter term://* startinsert
            "" Toggle numbers off when in terminal mode, on when in normal mode
            autocmd TermEnter term://* setlocal nonu nornu
            autocmd TermLeave term://* setlocal nu rnu
            "" Immediately close terminal window when process finishes
            autocmd TermClose term://* close
        augroup END
    else
        "" Use Alt + ; to go to normal mode
        tnoremap <A-:> <C-w><S-n>
        "" Use Alt + Shift + ; to go to command mode
        tnoremap <A-:> <C-w><S-n>:
        cnoreabbrev vterm vert term
    endif

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
