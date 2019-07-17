" plug stuff
call plug#begin('~\AppData\Local\nvim\plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'C:\ProgramData\chocolatey\bin\fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/vim-fullscreen'
Plug 'flazz/vim-colorschemes'
Plug 'ervandew/supertab' " tab triggers autocomplete
Plug 'ycm-core/YouCompleteMe'
call plug#end()
" goyo settings
"let g:goyo_width=80
" Setting some decent VIM settings for programming

set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=dark             " Use colours that work well on a dark background (Console is usually black)
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
syntax on                       " turn syntax highlighting on by default
set encoding=utf-8 " required for YCM

"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    "Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8

    "Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && expand("%") !~ "COMMIT_EDITMSG"
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff"
      \           && expand("%") !~ "git-rebase-todo" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff
      autocmd BufNewFile,BufRead *.diff set filetype=diff

      autocmd Syntax diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

      autocmd Syntax gitcommit setlocal spell textwidth=74
endif " has("autocmd")

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab
" Run current file (as python)
nnoremap <F5> :w<CR>:!python "%"<CR>
" Run current file but get args
nnoremap <S-F5> :w<CR>:!python "%"
let g:python_host_prog='C:\Users\Thale\AppData\Local\Programs\Python\Python37-32\python.exe'
" leader shortcuts
let mapleader="," " leader is comma

" Copied from regular vimrc
" tab like navigation
nnoremap <F1> :tabprev<CR>
nnoremap <F2> :tabnext<CR>
inoremap <F1> <C-O>:tabprev<CR>
inoremap <F2> <C-O>:tabnext<CR>
if has("nvim")
  tnoremap <F1> <C-\><C-N>:tabprev<CR>
  tnoremap <F2> <C-\><C-N>:tabnext<CR>
endif

map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" fzf stuff
map <C-p> :Buffers<CR>
map ; :FZF<CR>
" map leader f to search all buffers for curr word
map <leader>f :Lines <C-r><C-w><CR>
imap <leader>f <C-o>:Lines <C-r><C-w><CR>

" fullscreen for nvim
if has("nvim") " && exists('g:GuiLoaded')
  tnoremap <Esc> <C-\><C-n>
  let g:fullscreen#enable_default_keymap = 0
  let g:fullscreen#start_command = "call rpcnotify(0, 'Gui', 'WindowFullScreen', 1)"
  let g:fullscreen#stop_command = "call rpcnotify(0, 'Gui', 'WindowFullScreen', 0)"
  imap <silent> <F11> <C-o><Plug>(fullscreen-toggle)
  nmap <silent> <F11> <Plug>(fullscreen-toggle)
endif " nvim & gui

colorscheme PaperColor " colorscheme?
" tango-desert, PapayaWhip
syntax enable

"Tab settings
set tabstop=2 " number of spaces per tab
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2 " make > work
set expandtab " tabs are spaces sorry about it
set autoindent

" UI
set number " show line numbers
set showcmd " show last command
" set cursorline " highlight current line
filetype indent on " file-type specific indentation
set wildmenu " visual autocomplete
set lazyredraw " redraw only when necessary
set showmatch " highlight matching brackets & parens
set colorcolumn=100 " highlight column 80
set mouse=a "enable mouse support
set linebreak " break lines at word boundaries

" search
set incsearch " incremental search on
set hlsearch " highlight matches, turn off with :nohlsearch
set ignorecase " ignore case
set smartcase " don't ignore if I'm using mix of upper & lower?

" folding
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent " fold based on indent level

" movement
nnoremap j gj
nnoremap k gk

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" natural split opening
set splitbelow
set splitright

" move to beginning/end of line
"nnoremap B ^
"nnoremap E $

" $/^ off
"nnoremap $ <nop>
"nnoremap ^ <nop>

" edit vimrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" reload file if it changes
set autoread

" edit statusline
set laststatus=2
set statusline=%f " full filepath
set statusline+=%= " left/right separator
set statusline+=%c,%l/%L " cursor location

" set cygwin as default term
" bash opens in pwd
"let $CHERE_INVOKING=1
" Default path for Cygwin 64-bit, change accordingly
"set shell=C:\cygwin\bin\bash.exe

" Without --login, Cygwin won't mount some directories such as /usr/bin/
"set shellcmdflag=--login\ -c

" Default value is (, but bash needs "
"set shellxquote=\"

" Paths will use / instead of \
"set shellslash
