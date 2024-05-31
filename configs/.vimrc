"Vim

let mapleader="\<Space>"
call plug#begin()
  " curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  Plug 'preservim/nerdtree'
  Plug 'christoomey/vim-tmux-navigator' "tmux and vim window switcher BEST
  Plug 'itchyny/lightline.vim' "status bar
  Plug 'preservim/nerdcommenter'
  Plug 'https://github.com/rafi/awesome-vim-colorschemes'
  Plug 'vim-scripts/AutoComplPop' "auto completion pops up automatically instead of <C-p>
  Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
  Plug 'kshenoy/vim-signature' "view your marks
  Plug 'Yggdroot/indentLine' "show indent lines
call plug#end()

" functions
  function! BookmarkDir()
    if exists("g:NERDTree") && g:NERDTree.IsOpen()
      :Bookmark
    else
      echo "NERDTree not Open"
    endif
  endfunction

  function! DiffWindo()
    if &diff
      :windo diffoff
    else
      if len(tabpagebuflist()) > 1
        ":window diffthis
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

  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction

  function! ToggleNERDTree()
    if exists("g:NERDTree")
      if g:NERDTree.IsOpen()
        :NERDTreeClose
      else
        :NERDTreeFind
      endif
    else
      :25Lex
    endif
  endfunction
" Done

"Settings for plugins
  set background=dark
  " colorscheme gruvbox "afterglow
  "hi Normal guibg=NONE ctermbg=NONE "makes backdround transparent
  
  nnoremap <leader>e :call ToggleNERDTree()<CR>

  "for commenting. nerdcommenter toggle is <leader>c<Space>.
  map <leader>/ <space>c<space>
"Done

"Basic Defaults
  set clipboard=unnamed
  syntax enable
  set grepprg=git\ grep\ -n
  set cmdheight=2 "more space in the neovim command line for displaying messages
  set pumheight=10 "pop up menu height
  set termguicolors "set term gui colors (most terminals support this)
  set timeoutlen=500 "time to wait for a mapped sequence to complete (in milliseconds)
  set updatetime=300 "            -- faster completion (4000ms default)
  set cursorline " = true,             -- highlight the current line
  set sidescrolloff=8 ",
  set backspace=indent,eol,start "allow backspace to work
  set mouse=a  
  set cursorline
  set tabstop=2 softtabstop=2
  set shiftwidth=2
  set encoding=UTF-8
  set expandtab
  set smartindent
  set nu
  " set relativenumber
  set nowrap
  set noswapfile
  set scrolloff=8
  set colorcolumn=80
  set laststatus=2
  set complete+=kspell
  set completeopt=menuone,longest
  set wildmode=list,full
  set confirm
  set encoding=utf-8
      
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

  nnoremap <C-w>t :tabnew %<CR>
  nnoremap Y y$

  "replace words faster
  nnoremap <leader>r <Esc>yiw:%s/<C-R>"//gc<LEFT><LEFT><LEFT>
  vnoremap <leader>r yy:%s/<C-R>"//gc<LEFT><LEFT><LEFT>

  "complie and run code faster
  cnoremap ,cpp !g++ <C-r>%;./a.out 
  cnoremap ,py !python3 <C-r>%

  "open a new tab
  nnoremap <leader>t :tabnew<CR>:Ex<CR>
  nnoremap <leader>q :call QuickFixToggle()<CR>

  nnoremap <leader>V :tabnew $MYVIMRC<CR>:cd %:p:h<CR>
  nnoremap <leader><leader> :w<cr>:source $MYVIMRC <CR>

  "If PUM (complete menu) is visible, then execute <C-y> (which selects an "item), otherwise regular tab
  inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"

  nnoremap <leader>x :!chmod +x %<CR>

  "starter templates for files
  nnoremap ,cpp :r ~/dotfiles/other/skeletons/cpp<CR>gg"_dd4j
  nnoremap ,html :r ~/dotfiles/other/skeletons/html<CR>gg"_dd9j
  nnoremap ,java :r !bash ~/dotfiles/other/skeletons/java.sh %<CR>gg"_dd2j

  nnoremap H ^
  nnoremap L $
  vnoremap H ^
  vnoremap L $

  "compare windows
  nnoremap <leader>d :call DiffWindo()<CR>

  nnoremap  <leader>bd :bdelete<CR>
  nnoremap  <leader>bn :bnext<CR>
  nnoremap  <leader>bp :bprev<CR>
"Done Remapings

"Other Things
  "c++ formatting :help cinoptions-values 
  autocmd FileType cpp set cinoptions=l1 

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
