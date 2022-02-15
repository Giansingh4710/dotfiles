syntax on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set relativenumber
set nowrap
set noswapfile
set incsearch
set nohlsearch
set scrolloff=8
set colorcolumn=80
set laststatus=2
set complete+=kspell
set completeopt=menuone,longest
set wildmode=list,full
set omnifunc=syntaxcomplete#complete
set background=dark
let mapleader="\<Space>"
filetype plugin on
set t_Co=256

" :PlugInstall to install plugins
call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
    nnoremap <leader>n :NERDTreeFocus<CR>
    nnoremap <C-n> :NERDTree<CR>
    nnoremap <C-t> :NERDTreeToggle<CR>
    nnoremap <C-f> :NERDTreeFind<CR>

    Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
    Plug 'terryma/vim-multiple-cursors'
    Plug 'itchyny/lightline.vim' "the cool bar on the bottom that tells you if your in instert/command/normal mode 
    Plug 'vim-scripts/AutoComplPop' "auto completion pops up automaticaly instead of <C-p>
    Plug 'https://github.com/ycm-core/YouCompleteMe.git'
    nnoremap  <leader>gd :YcmCompleter GoTo<CR>

    Plug 'preservim/nerdcommenter'
    "for commenting. nerdcommenter toggle is <leader>c<Space>.
    map <leader>/ <space>c<space>

    Plug 'NLKNguyen/papercolor-theme' "colorscheme
    Plug 'morhetz/gruvbox' "color scheme
call plug#end()

colorscheme gruvbox
"colorscheme PaperColor

"from youtub vid. make it eaiser to move between multiple vids
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

"I like html files to only be indented by 2 spaces instead of normal 4
autocmd FileType html,javascript set tabstop=2
autocmd FileType html,javascript set softtabstop=2
autocmd FileType html,javascript set shiftwidth=2

inoremap jk <ESC>

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
cnoremap cpp !g++ <C-r>%;./a.out 
cnoremap py !python3 <C-r>%

" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
"copies to system clipboard on YY
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
