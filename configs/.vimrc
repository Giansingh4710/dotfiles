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

"Basic Defaults
  set shortmess-=S " trying to get the [3/6] searching to work
  set background=dark
  set clipboard=unnamed
  syntax enable
  set grepprg=git\ grep\ -n
  set cmdheight=2 "more space in the neovim command line for displaying messages
  set pumheight=10 "pop up menu height
  set timeoutlen=500 "time to wait for a mapped sequence to complete (in milliseconds)
  set updatetime=300 "            -- faster completion (4000ms default)
  set cursorline " = true,             -- highlight the current line
  set sidescrolloff=8 ",
  set backspace=indent,eol,start "allow backspace to work
  set mouse=a
  set cursorline
  set encoding=UTF-8

  set expandtab
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2

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
  set hlsearch
  set ignorecase
  set smartcase
  nnoremap <Leader><CR> :nohlsearch<CR>
  set showcmd
  set wildmenu
"Done

"Remapings
  set path+=**
  let g:netrw_banner=0    " disable annoying banner
  let g:netrw_liststyle=3 " open folders instead of going in them

  nnoremap <leader>ft :vimgrep  **<LEFT><LEFT><LEFT>
  nnoremap <leader>ff :find 
  nnoremap <leader>S : source ~/.vimrc <CR>

  nnoremap H ^
  nnoremap L $
  vnoremap H ^
  vnoremap L $
  inoremap jk <ESC>
  nnoremap - :Ex<CR>
  nnoremap Y y$

  "open a new tab
  nnoremap <leader>t :tabnew<CR>:Ex<CR>
  nnoremap <C-w>t :tabnew %<CR>

  "replace words faster
  nnoremap <leader>r <Esc>yiw:%s/<C-R>"//gc<LEFT><LEFT><LEFT>
  vnoremap <leader>r yy:%s/<C-R>"//gc<LEFT><LEFT><LEFT>
  
  nnoremap <leader>c :%s//&/n<CR> " get count
  nnoremap <leader>x :!chmod +x %<CR>

  "make it easier to resize
  nnoremap <leader>h :wincmd <<CR>
  nnoremap <leader>j :wincmd +<CR>
  nnoremap <leader>k :wincmd -<CR>
  nnoremap <leader>l :wincmd ><CR>

  nnoremap <leader>V :tabnew $MYVIMRC<CR>:cd %:p:h<CR>
  nnoremap <leader><leader> :w<cr>:source $MYVIMRC <CR>
"Done Remapings

" functions
  function! FormatCSV()
    let lstart = line("'<")
    let lend = line("'>")

    let max_lengths = [] " Initialize a list to store the maximum length of each column

    " First pass to calculate the max length of each column
    for lnum in range(lstart, lend)
      let line = getline(lnum)
      let fields = map(split(line, ',\s*'), 'trim(v:val)')
      for i in range(len(fields))
        if len(max_lengths) <= i
          call add(max_lengths, 0)
        endif
        let max_lengths[i] = max([max_lengths[i], strlen(fields[i])])
      endfor
    endfor

    " Second pass to format the lines
    for lnum in range(lstart, lend)
      let line = getline(lnum)
      let fields = map(split(line, ',\s*'), 'trim(v:val)')
      let formatted_line = ''
      for i in range(len(fields))
        let padding = max_lengths[i] - strlen(fields[i])
        let formatted_line .= fields[i] . repeat(' ', padding)
        if i < len(fields) - 1
          let formatted_line .= ', '
        endif
      endfor
      call setline(lnum, formatted_line)
    endfor
  endfunction
  vnoremap <leader>fc :call FormatCSV()<CR>

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

  let g:quickfix_is_open = 0  " Initialize a global variable
  function! QuickFixToggle()
    if g:quickfix_is_open
      cclose
      let g:quickfix_is_open = 0
    else
      copen
      let g:quickfix_is_open = 1
    endif
  endfunction
  nnoremap <leader>q :call QuickFixToggle()<CR>

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
" Done
"
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

  "WSL yank support
  let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path
  if executable(s:clip)
    augroup WSLYank
      autocmd!
      autocmd TextYankPost * if v:event.operator ==# 'y' |call system(s:clip, @0) | endif
    augroup END
  endif
"Done
