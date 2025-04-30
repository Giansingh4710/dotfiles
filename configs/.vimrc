"Vim

let mapleader="\<Space>"
call plug#begin()
  " curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  Plug 'preservim/nerdtree'
  Plug 'christoomey/vim-tmux-navigator' "tmux and vim window switcher BEST
  Plug 'itchyny/lightline.vim' "status bar
  Plug 'preservim/nerdcommenter'
  Plug 'vim-scripts/AutoComplPop' "auto completion pops up automatically instead of <C-p>
  Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
  Plug 'Yggdroot/indentLine' "show indent lines
  " Plug 'https://github.com/rafi/awesome-vim-colorschemes'
  " Plug 'kshenoy/vim-signature' "view your marks
call plug#end()

" functions
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
  nnoremap <leader>dw :call DiffWindo()<CR>

  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
  nnoremap <leader>q :call QuickFixToggle()<CR>

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
  nnoremap <leader>e :call ToggleNERDTree()<CR>

  function! SplitLongLine()
    let line = getline('.')
    let line = substitute(line, '^\s*\(.\{-}\)\s*$', '\1', '') " trim leading/trailing whitespace
    let spaces = matchstr(getline('.'), '^\s*') " preserve leading spaces
    let line_length = strlen(line)

    if line_length <= 80
      return
    endif

    let words = split(line)
    let lines = []
    let current_line = spaces

    for i in range(len(words))
      let word = words[i]
      if i == 0
        let new_line = current_line . word
      else
        let new_line = current_line . ' ' . word
      endif

      if strlen(new_line) <= 80
        let current_line = new_line
      else
        call add(lines, current_line)
        let current_line = spaces . word
      endif
    endfor

    call add(lines, current_line)

    " Replace the current line with the split lines
    let lnum = line('.')
    call setline(lnum, lines[0])
    if len(lines) > 1
      call append(lnum, lines[1:])
    endif
  endfunction

  nnoremap <leader>s :call SplitLongLine()<CR>

  let g:terminal_bufnr = -1
  let g:last_buffer_before_terminal = -1
  function! ToggleTerminal()
    let in_terminal = &buftype ==# 'terminal'
    if in_terminal
      let curr_terminal = bufnr('%')
      hide
      if bufexists(g:last_buffer_before_terminal) && g:last_buffer_before_terminal != -1
        execute 'buffer ' . g:last_buffer_before_terminal
      endif
      let g:terminal_bufnr = curr_terminal
      return
    endif
    
    let g:last_buffer_before_terminal = bufnr('%')
    if bufexists(g:terminal_bufnr) && getbufvar(g:terminal_bufnr, '&buftype') ==# 'terminal'
      let terminal_window = bufwinnr(g:terminal_bufnr)
      if terminal_window != -1
        execute terminal_window . 'wincmd w'
      else
        botright split
        execute 'buffer ' . g:terminal_bufnr
        startinsert
      endif
    else
      botright split
      terminal
      let g:terminal_bufnr = bufnr('%')
      startinsert
    endif
  endfunction
  nnoremap <silent> \\ :call ToggleTerminal()<CR>
  tnoremap <silent> \\ <C-\><C-n>:call ToggleTerminal()<CR>
" Done

"Settings for plugins
  set background=dark
  " colorscheme gruvbox "afterglow
  " hi Normal guibg=NONE ctermbg=NONE "makes backdround transparent


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
  nnoremap - :Ex<CR>

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
