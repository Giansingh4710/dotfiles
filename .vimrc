syntax on
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

set timeoutlen=500

imap ii <Esc>
nnoremap Y y$
nnoremap B 0
nnoremap E E$
nnoremap <C-Up> <Up>"add"ap<Up>
nnoremap <C-Down> "add"ap
nnoremap <Tab> <Esc>

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
