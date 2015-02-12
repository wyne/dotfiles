" Fresh Start Steps
"
" 1. setup vundle
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
" 2. prepare directory for backups
"   mkdir -p ~/.vim/tmp/swap ~/.vim/tmp/backup ~/.vim/tmp/undo
" 3. Install silver searcher
"   https://github.com/rking/ag.vim

set nocompatible
set encoding=utf-8
" Since Fish isn't POSIX compliant
set shell=/bin/bash

" switch between YCM and NeoComplete
let neocomplete_mode = 1
if has("mac")
  let neocomplete_mode = 0
endif

" start vundler
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" core plugins
Plugin 'gmarik/Vundle.vim'              " Required
Plugin 'flazz/vim-colorschemes'         " Set of color schemes http://bytefluent.com/vivify/
Plugin 'kien/ctrlp.vim'                 " File search
Plugin 'scrooloose/nerdtree'            " Directory browsing
Plugin 'tpope/vim-sensible'             " Sensible defaults
Plugin 'tpope/vim-fugitive'             " Git commands

" other plugins
Plugin 'sjl/gundo.vim'                  " Undo Tree
Plugin 'Shougo/neocomplcache'           " Autocompletion
Plugin 'terryma/vim-multiple-cursors'   " Sublime style repeat word select
Plugin 'bling/vim-airline'              " Status bar
Plugin 'xolox/vim-misc'                 " Requirement for session management
Plugin 'xolox/vim-session'              " Session management
Plugin 'henrik/vim-indexed-search'      " Show N of M matches during search
Plugin 'rking/ag.vim'                   " Searching

" end vundler
call vundle#end()
filetype plugin indent on

" airline
if !exists("g:airline_symbols")
  let g:airline_symbols = {}
endif

let g:airline_theme="bubblegum"
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#empty_message  =  "No SCM"
let g:airline#extensions#whitespace#enabled    =  0
let g:airline#extensions#syntastic#enabled     =  1
let g:airline#extensions#tabline#enabled       =  1
let g:airline#extensions#tabline#tab_nr_type   =  1   " tab number
let g:airline#extensions#tabline#fnamemod      = ':t' " filename only
let g:airline#extensions#hunks#non_zero_only   =  1   " git gutter

" general configs
syntax on
set number        " always show line numbers
set nowrap        " don't wrap lines
set ruler         " show cursor line and column in status bar
set hidden
set cursorline
:hi CursorLine cterm=none ctermbg=black ctermfg=none
set expandtab
set tabstop=4     " a tab is four spaces
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=4  " number of spaces to use forautoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set wildignore=*.swp,*.bak,*.pyc,*.class
set pastetoggle=<f2>

" show trailing whitespaces
set list
set listchars=tab:▸\ ,trail:¬,nbsp:.,extends:❯,precedes:❮
augroup FileTypes
  autocmd!
  autocmd filetype html,xml set listchars-=tab:▸\ 
augroup END

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "yes"
let g:session_command_aliases = 1

" backup settings
set history=1000
set undolevels=1000
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backupskip=/tmp/*,/private/tmp/*"
set backup
set writebackup
set noswapfile
set nobackup
set noswapfile

" change cursor shape in different modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" remaps
let mapleader=","

nnoremap <C-j> :bn<CR>
nnoremap <C-k> :bN<CR>

nnoremap <leader>v      :e ~/personal/dotfiles/.vimrc<CR>
nnoremap <leader>V      :so $MYVIMRC<CR>
nnoremap <leader>ps     :PluginSearch<CR>
nnoremap <leader>PS     :PluginSearch!<CR>
nnoremap <leader>pr     :BundleInstall<CR>
nnoremap <leader>gundo  :GundoToggle<CR>
nnoremap <leader>f      :CtrlP<Space>.<CR>
nnoremap <leader>b      :CtrlPBuffer<CR>
nnoremap <leader>gs     :Gstatus<CR>
nnoremap <leader>so     :OpenSession 
nnoremap <leader>ss     :SaveSession 
nnoremap <leader>sd     :DeleteSession<CR>
nnoremap <leader>sc     :CloseSession<CR>

" allow copying selection in visual mode
vnoremap <C-x> :w !pbcopy<cr>
nnoremap <C-a> :nerdtreetoggle<cr>

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
