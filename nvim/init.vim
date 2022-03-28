"Neo Vim

let mapleader="\<Space>"
call plug#begin('~/.vim/plugged')
    Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
    Plug 'mattn/emmet-vim' "autocomplet tags
    Plug 'itchyny/lightline.vim' "status bar
    Plug 'kshenoy/vim-signature' "view your marks
    Plug 'preservim/nerdtree'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
    Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
    "Plug 'vim-scripts/AutoComplPop' "auto completion pops up automaticaly instead of <C-p>
    Plug 'preservim/nerdcommenter'
    Plug 'christoomey/vim-tmux-navigator' "tmux and vim window switcher BEST
    Plug 'Yggdroot/indentLine' "show indent lines
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } "css colors
    Plug 'https://github.com/rafi/awesome-vim-colorschemes'

    if has('nvim')
        Plug 'glepnir/dashboard-nvim' "nice dashboard when you do just nvim
        Plug 'nvim-lua/popup.nvim' " -- An implementation of the Popup API from vim in Neovim
        Plug 'nvim-lua/plenary.nvim' " -- Useful lua functions used ny lots of plugins
        Plug 'kyazdani42/nvim-web-devicons'
        Plug 'akinsho/toggleterm.nvim'
        Plug 'folke/which-key.nvim'
        Plug 'nvim-telescope/telescope.nvim'
        " -- cmp plugins
        Plug 'hrsh7th/nvim-cmp' " -- The completion plugin
        Plug 'hrsh7th/cmp-buffer' " -- buffer completions
        Plug 'hrsh7th/cmp-path' " -- path completions
        Plug 'hrsh7th/cmp-cmdline' " -- cmdline completions
        Plug 'saadparwaiz1/cmp_luasnip' " -- snippet completions
        Plug 'hrsh7th/cmp-nvim-lsp'
        " -- snippets
        Plug 'L3MON4D3/LuaSnip' " --snippet engine
        Plug 'rafamadriz/friendly-snippets' " -- a bunch of snippets to use
        " -- LSP
        Plug 'neovim/nvim-lspconfig' " -- enable LSP
        Plug 'williamboman/nvim-lsp-installer' " -- simple to use language server installer
        Plug 'tamago324/nlsp-settings.nvim' " -- language server settings defined in json for
        "Plug 'jose-elias-alvarez/null-ls.nvim' " -- for formatters and linters
        Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim' " toggle lsp on off
        " -- Treesitter
        Plug 'nvim-treesitter/nvim-treesitter',
        Plug 'JoosepAlviste/nvim-ts-context-commentstring'
        lua require('user')
    endif
call plug#end()

"Settings for plugins
    colorscheme dogrun
    hi Normal guibg=NONE ctermbg=NONE "makes backdround transparent
    
    "Nerd Tree
        nnoremap <leader>n :NERDTreeFocus<CR>
        "nnoremap <C-n> :NERDTree<CR>
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

    let g:Hexokinase_highlighters = [ 'backgroundfull' ]
    let g:lightline = {
                \ 'active': {
                    \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified'] ],
                    \ }
                    \ }
    "for commenting. nerdcommenter toggle is <leader>c<Space>.
    map <leader>/ <space>c<space>
    let g:user_emmet_leader_key='<'
    if has('nvim')
        "Dashboard when you type nvim
        let g:dashboard_default_executive ='telescope'
        let g:dashboard_custom_shortcut={
            \ 'last_session'       : 'SPC s l',
            \ 'find_history'       : 'SPC f h',
            \ 'find_file'          : 'SPC f f',
            \ 'new_file'           : 'SPC c n',
            \ 'change_colorscheme' : 'SPC t c',
            \ 'find_word'          : 'SPC f a',
            \ 'book_marks'         : 'SPC f b',
            \ }
    endif
"Done

"Basic Defaults
    syntax enable
    set cmdheight=2 "more space in the neovim command line for displaying messages
    set pumheight=10 "pop up menu height
    set termguicolors "set term gui colors (most terminals support this)
    set timeoutlen=500 "time to wait for a mapped sequence to complete (in milliseconds)
    set updatetime=300 "                        -- faster completion (4000ms default)
    set cursorline " = true,                       -- highlight the current line
    set sidescrolloff=8 ",
    set backspace=indent,eol,start "allow backspace to work
    set mouse=a  
    set cursorline
    set tabstop=4 softtabstop=4
    set shiftwidth=4
    set encoding=UTF-8
    set expandtab
    set smartindent
    set nu
    set relativenumber
    set nowrap
    set noswapfile
    set scrolloff=8
    set colorcolumn=80
    set laststatus=2
    set complete+=kspell
    set completeopt=menuone,longest
    set wildmode=list,full
    set confirm
            
    "set background=dark
    "set t_Co=256
    set foldmethod=indent
    "set nofoldenable "open folds when file open

    "better searching
    set incsearch
    "set hlsearch
    set ignorecase
    "set smartcase
    nnoremap <Leader><CR> :nohlsearch<CR>
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

    "starter for multiline comment for react,js,java type langs
    noremap gcc <ESC>O{/*<CR>*/}<ESC>
    nnoremap <leader>ev :tabnew $MYVIMRC<CR>:cd %:p:h<CR>
    nnoremap <leader>sv :w<cr>:source $MYVIMRC <CR>

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
                ":windo diffthis
                :10 wincmd l "go to the right most pane
                :diffthis
                :wincmd h "go to the pane on left and compare it to that
                :diffthis 
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
"Done
