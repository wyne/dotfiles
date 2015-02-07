" Fresh Start Steps
"
" 1. setup vundle
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
" 2. prepare directory for backups
"   mkdir -p ~/.vim/tmp/swap ~/.vim/tmp/backup ~/.vim/tmp/undo


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
Plugin 'gmarik/Vundle.vim'

" my plugins
Plugin 'tpope/vim-sensible'				" Sensible defaults
Plugin 'tpope/vim-fugitive'             " Git commands
Plugin 'sjl/gundo.vim'                  " Undo Tree
Plugin 'Shougo/neocomplcache'           " Autocompletion
Plugin 'airblade/vim-gitgutter'         " Git line status in gutter
Plugin 'terryma/vim-multiple-cursors'   " Sublime style repeat word select
Plugin 'scrooloose/nerdtree'			" Directory browsing
Plugin 'kien/ctrlp.vim'					" File search

" end vundler
call vundle#end()
filetype plugin indent on

" general configs
syntax on
set number        " always show line numbers
set nowrap        " don't wrap lines
set ruler         " show cursor line and column in status bar
set hidden

set cursorline    " highlight screen line of the cursor
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start " allow backspacing over everything in insert mode
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

set wildignore=*.swp,*.bak,*.pyc,*.class
set pastetoggle=<f2>

" backup settings
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backupskip=/tmp/*,/private/tmp/*"
set backup
set writebackup
set noswapfile
set nobackup
set noswapfile

" remaps
let mapleader=","

nnoremap <C-j> <C-n>
nnoremap <C-k> <C-p>

nnoremap <leader>v      :e ~/.vimrc<CR>
nnoremap <leader>v      :tabnew ~/.vimrc<CR>
nnoremap <leader>ps     :PluginSearch<CR>
nnoremap <leader>ps     :PluginSearch!<CR>
nnoremap <leader>bi     :BundleInstall<CR>
nnoremap <leader>gundo  :GundoToggle<CR>

nnoremap <C-a> :NERDTreeToggle<CR>

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
