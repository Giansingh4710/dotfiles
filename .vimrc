syntax enable
set nocompatible
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
set t_Co=256
set showcmd
let mapleader="\<Space>"

"fuzzy finder
filetype plugin on
set wildmenu
set path+=** "search every subdirectory in dir, and every dir in subdirectory

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
        nnoremap gd :YcmCompleter GoTo<CR>
    Plug 'preservim/nerdcommenter'
        "for commenting. nerdcommenter toggle is <leader>c<Space>.
        map <leader>/ <space>c<space>
    Plug 'NLKNguyen/papercolor-theme' "colorscheme
    Plug 'morhetz/gruvbox' "color scheme
    Plug 'christoomey/vim-tmux-navigator' "tmux and vim window switcher
call plug#end()

"colorscheme gruvbox
colorscheme PaperColor

"make it easier to resize
nnoremap <leader>h :wincmd <<CR>
nnoremap <leader>j :wincmd +<CR>
nnoremap <leader>k :wincmd -<CR>
nnoremap <leader>l :wincmd ><CR>

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

"starter templetes for files
nnoremap ,cpp :r ~/.dotfiles/skeletons/cpp<CR>gg"_dd4j
nnoremap ,html :r ~/.dotfiles/skeletons/html<CR>gg"_dd9j
nnoremap ,java :r !bash ~/.dotfiles/skeletons/java.sh %<CR>gg"_dd2j

"for highlighting Yanked Text
function! DeleteTemporaryMatch(timerId)
        call matchdelete(g:idTemporaryHighlight)
endfunction

function! FlashYankedText()
    let g:idTemporaryHighlight = matchadd('IncSearch', ".\\%>'\\[\\_.*\\%<']..")
    call timer_start(500,"DeleteTemporaryMatch")
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
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

"WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' |call system(s:clip, @0) | endif
    augroup END
endif
