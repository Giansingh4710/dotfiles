set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set relativenumber
"set nowrap
set incsearch
set scrolloff=8
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" :PlugInstall to install plugins
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox' "color scheme
Plug 'lyuts/vim-rtags'
Plug 'https://github.com/ycm-core/YouCompleteMe.git'
call plug#end()

colorscheme gruvbox
set background=dark

"set timeoutlen=500

"delete from the begginig of the line to cursor
nnoremap <Bslash> I//<ESC>

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
nnoremap <C-b> <C-w><C-v>:Ex<Enter>:vertical resize 30 <Enter> 

"replace words faster
nnoremap <C-r> <Esc>yiw:%s/<C-R>"//gc<LEFT><LEFT><LEFT>

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
let &t_SI = "\e[6 q"
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
