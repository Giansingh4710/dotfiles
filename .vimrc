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
set scrolloff=8
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
set laststatus=2

" :PlugInstall to install plugins
call plug#begin('~/.vim/plugged')
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'terryma/vim-multiple-cursors'
Plug 'NLKNguyen/papercolor-theme'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox' "color scheme
Plug 'lyuts/vim-rtags'
Plug 'https://github.com/ycm-core/YouCompleteMe.git'
call plug#end()

" Default mapping for vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

set background=dark
colorscheme PaperColor
"colorscheme gruvbox
set background=dark

"set timeoutlen=500

let mapleader="\<Space>"

"from youtub vid. make it eaiser to move between multiple vids
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>

"delete from the begginig of the line to cursor
nnoremap <Bslash> I//<ESC>
nnoremap <leader><Bslash> I<DEL><DEL><ESC>
vnoremap <Bslash> :norm I//<CR> 
vnoremap <leader><Bslash> :norm ^xx<CR> 

augroup commenting
   autocmd!
   autocmd FileType python,sh nnoremap <Bslash> I#<ESC>
   autocmd FileType python,sh nnoremap <leader><Bslash> I<DEL><ESC>
   autocmd FileType python,sh vnoremap <Bslash> :norm I#<CR> 
   autocmd FileType python,sh vnoremap <leader><Bslash> :norm ^x<CR>

   autocmd FileType html nnoremap <Bslash> I<!-- <ESC>A--><Esc>^
   autocmd FileType html nnoremap <leader><Bslash> ^5x $F-;4x<Esc>^
   autocmd FileType html vnoremap <Bslash> :norm I<!-- <C-o>A --><Esc>
   autocmd FileType html vnoremap <leader><Bslash> :norm ^5x $4h4x<ESC>
augroup END
autocmd FileType vim nnoremap <Bslash> I"<ESC>
autocmd FileType vim nnoremap <leader><Bslash> I<DEL><ESC>
autocmd FileType vim vnoremap <Bslash> :norm I"<CR> 
autocmd FileType vim vnoremap <leader><Bslash> :norm ^x<CR>


"yank till end of line
nnoremap Y y$

"Go to Begining of line
nnoremap B 0

"Go to end of line
nnoremap E E$

"<C-up> in vscode to move line up and down
inoremap <C-Down> <ESC>ddpi
inoremap <C-Up> <ESC>ddkPi
nnoremap <C-Down> <ESC>ddp
nnoremap <C-Up> <ESC>ddkP

"<C-up> in vscode to move line up and down
inoremap <A-Down> <ESC>yypi
inoremap <A-Up> <ESC>yyPi
nnoremap <A-Down> <ESC>yyp
nnoremap <A-Up> <ESC>yyP

"<C-b> from vscode. to open up file directory on left
nnoremap <C-b> :wincmd v<ENTER>:Ex<ENTER>:vertical resize 30 <CR> 

"replace words faster
nnoremap <leader>r <Esc>yiw:%s/<C-R>"//gc<LEFT><LEFT><LEFT>
vnoremap <leader>r yy:%s/<C-R>"//gc<LEFT><LEFT><LEFT>

"complie and run code faster
cnoremap cpp !g++ <C-r>%;./a.out 
cnoremap py !python3 <C-r>%


"copies to system clipboard on YY
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
   "augroup WSLYank
       "autocmd!
       "autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
   "augroup END
endif
