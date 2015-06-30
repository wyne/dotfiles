" ========== Fresh Start Steps =========={{{
"
" 1. Setup vundle
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
" 2. Prepare directory for backups
"   mkdir -p ~/.vim/tmp/swap ~/.vim/tmp/backup ~/.vim/tmp/undo
"
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
Plugin 'mustache/vim-mustache-handlebars' " Mustache
Plugin 'solarnz/thrift.vim'             " Thrift syntax

"  end vundler
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

" }}}
" ========== GENERAL CONFIGS =========="{{{

syntax on
set number        " always show line numbers
set nowrap        " don't wrap lines
set ruler         " show cursor line and column in status bar
set hidden
set cursorline    " highlight current line
:hi CursorLine cterm=none ctermbg=black ctermfg=none
:hi Folded ctermbg=white
:hi Pmenu ctermfg=white ctermbg=4
:hi PmenuSel ctermfg=white ctermbg=1
set foldmethod=indent
set foldlevel=15
set expandtab     " use spaces intead of tabs
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
set scrolloff=2     " start scrolling when 2 lines from edge
set sidescroll=1    " scroll horizontally by 3 columns
set sidescrolloff=2 " start scrolling horizontally when 2 lines from edge

" other auto syntax
au BufRead,BufNewFile *.mustache setfiletype mustache
au BufRead,BufNewFile *.thrift set syntax=thrift
au BufRead,BufNewFile *.aurora set syntax=ruby

" show trailing whitespaces
set list
set listchars=tab:▸\ ,trail:¬,nbsp:.,extends:❯,precedes:❮
augroup FileTypes
  autocmd!
  autocmd filetype html,xml set listchars-=tab:▸\ 
augroup END

" }}}
" ========== SESSION MANAGEMENT =========={{{

let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "yes"
let g:session_command_aliases = 1

" }}}
" ========== BACKUP SETTINGS =========={{{

set history=1000
set undolevels=1000
set undodir=~/.vim/tmp/undo/
set undofile
set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/swap/
set backupskip=/tmp/*,/private/tmp/*
set backup
set writebackup
set noswapfile
set nobackup
set noswapfile

" }}}
" ========== CURSOR =========={{{

" change cursor shape in different modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" }}}
" ========== LEADER =========={{{

" Set <space> to leader key
let mapleader=" "
"                         Edit .vimrc
nnoremap <leader>v        :e ~/personal/dotfiles/.vimrc<CR>
"                         Reload .vimrc
nnoremap <leader>V        :so $MYVIMRC<CR>
"                         Seach vundle plugins
nnoremap <leader>ps       :PluginSearch<CR>
"                         Search vundle plugins and force refresh
nnoremap <leader>PS       :PluginSearch!<CR>
"                         Update plugins to latest version
nnoremap <leader>pr       :BundleInstall<CR>
"                         Open Gundo (Undo Tree)
nnoremap <leader>u        :GundoToggle<CR>
"                         Hide highlighing (such as after a search)
nnoremap <leader>h        :noh<CR>
"                         Search by file name
nnoremap <leader>o        :CtrlP<Space>.<CR>
"                         Seach by open buffers
nnoremap <leader>b        :CtrlPBuffer<CR>
"                         Git status
nnoremap <leader>gs       :Gstatus<CR>
"                         Git commit
nnoremap <leader>gc       :Gcommit<CR>
"                         Open vim session (press tab for completion)
nnoremap <leader>so       :OpenSession 
"                         Save vim session (press tab for completion)
nnoremap <leader>ss       :SaveSession 
"                         Delete vim session
nnoremap <leader>sd       :DeleteSession<CR>
"                         Close vim session
nnoremap <leader>sc       :CloseSession<CR>
"                         Save current file
nnoremap <leader>w        :w<CR>
"                         Quit while maintaining window arrangement for session
nnoremap <leader>q        :qa<CR>
"                         Next window
nnoremap <leader><leader> <C-w><C-w>
"                         Open native file browser
nnoremap <leader>k        :E<CR>
"                         Close current buffer and maintain window arrangement
nnoremap <leader>x        :bp\|bd #<CR>
"                         Search working directory
nnoremap <leader>f        :Ag 
nnoremap <leader>t        :AgFile 
"                         Reveal file in NerdTree
nnoremap <leader>r        :NERDTreeFind<CR>

" }}}
" ========== OTHER MAPPINGS =========={{{

"                 Copy selection in visual mode
vnoremap <C-x>    :w !pbcopy<CR>
"                 Open NERDTree File Browser
nnoremap <Bslash> :NERDTreeToggle<CR>
"                 Next buffer
nnoremap <Tab>    :bn<CR>
"                 Previous buffer
nnoremap <S-Tab>  :bN<CR>
"                 Grow pane horizontally
nnoremap <C-l>    :5winc ><CR>
"                 Shrink pane horizontally
nnoremap <C-h>    :5winc <<CR>
"                 Grow pane vertically
nnoremap <C-J>    :5winc +<CR>
"                 Shrink pane vertically
nnoremap <C-K>    :5winc -<CR>
"                 Search working directory for word under cursor
nnoremap <C-g>    :Ag <cword><CR>
"                 Search working directory
nnoremap <C-a>    :Ag 
"                 Open and close folds
nnoremap ,        za

" Swap ; and : for easier type of commands
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" }}}

" vim:foldmethod=marker:foldlevel=0
