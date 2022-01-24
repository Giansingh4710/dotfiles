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
nnoremap E E$
nnoremap <C-Up> <Up>"add"ap<Up>
nnoremap <C-Down> "add"ap
nnoremap <Tab> <Esc>
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

