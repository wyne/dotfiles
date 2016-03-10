" ========== Fresh Start Steps ==========
" 1. Install neovim
"   https://github.com/neovim/homebrew-neovim/blob/master/README.md
"   pip install --user neovim
"
" 2. Install patched fonts - Optional
"   http://powerline.readthedocs.org/en/latest/installation/osx.html
"   https://github.com/powerline/fonts.git
"   ./install.sh
" =======================================

" auto install plugins

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" auto create backup directories

if empty(glob('~/.config/nvim/tmp/swap'))
  silent !mkdir -p ~/.config/nvim/tmp/swap ~/.config/nvim/tmp/backup ~/.config/nvim/tmp/undo
endif

" plugins

call plug#begin('~/.config/nvim/bundle')

" core plugins

Plug 'tpope/vim-sensible'               " Sensible defaults
Plug 'flazz/vim-colorschemes'           " Set of color schemes
Plug 'scrooloose/nerdtree'              " Directory browsing
Plug 'tpope/vim-fugitive'               " Git commands
Plug 'tpope/vim-surround'               " Vim-surround
Plug 'tpope/vim-commentary'             " Vim-commentary
Plug 'morhetz/gruvbox'                  " Color scheme
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" other plugins

Plug 'Chiel92/vim-autoformat'           " Code Formatting
Plug 'Shougo/deoplete.nvim'             " Autocomplete for nvim
Plug 'Valloric/ListToggle'              " Toggle location list
Plug 'benekastah/neomake'               " Syntax checking
Plug 'easymotion/vim-easymotion'        " Fast movement
Plug 'godlygeek/tabular'                " Alignment
Plug 'henrik/vim-indexed-search'        " Show N of M matches during search
Plug 'junegunn/goyo.vim'                " Markdown
Plug 'kchmck/vim-coffee-script'         " Coffeescript
Plug 'mhinz/vim-signify'                " Git gutter
Plug 'mustache/vim-mustache-handlebars' " Mustache
Plug 'osyo-manga/vim-over'              " Search and replace preview
Plug 'rking/ag.vim'                     " Searching
Plug 'sjl/gundo.vim'                    " Undo Tree
Plug 'slim-template/vim-slim'           " Slim syntax
Plug 'solarnz/thrift.vim'               " Thrift syntax
Plug 'terryma/vim-expand-region'        " Expand regions
Plug 'terryma/vim-multiple-cursors'     " Sublime style repeat word select
Plug 'tpope/vim-dispatch'               " Tmux integration
Plug 'tpope/vim-unimpaired'             " Move text
Plug 'vim-airline/vim-airline'          " Status bar
Plug 'wellle/targets.vim'               " Additional text objects
Plug 'wesQ3/vim-windowswap'             " Window swapping
Plug 'xolox/vim-misc'                   " Requirement for session management
Plug 'xolox/vim-session'                " Session management
Plug 'yssl/QFEnter'                     " Choose window for quick fix open

call plug#end()

" ========== GENERAL CONFIG ==========

syntax on
colorscheme gruvbox

set background=dark
set nowrap          " don't wrap lines
set ruler           " show cursor line and column in status bar
set hidden
set cursorline      " highlight current line
set re=1            " fixes slow cursorline
set expandtab       " use spaces intead of tabs
set tabstop=2       " a tab is four spaces
set smarttab        " insert tabs on the start of a line according to shiftwidth, not tabstop
set autoindent      " always set autoindenting on
set copyindent      " copy the previous indentation on autoindenting
set shiftwidth=2    " number of spaces to use forautoindenting
set shiftround      " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch       " set show matching parenthesis
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is all lowercase
set incsearch       " show search matches as you type
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set wildignore=*.swp,*.bak,*.pyc,*.class
set pastetoggle=<f2>
set scrolloff=2     " start scrolling when 2 lines from edge
set sidescroll=1    " scroll horizontally by 1 column
set sidescrolloff=2 " start scrolling horizontally when 2 lines from edge
set colorcolumn=80  " Column ruler at 80 characters
set number

let NERDTreeShowHidden=1

" Set file types

au BufRead,BufNewFile *.mustache setfiletype mustache
au BufRead,BufNewFile *.thrift set syntax=thrift
au BufRead,BufNewFile *.aurora set syntax=ruby
au BufRead,BufNewFile *.json.jbuilder set syntax=ruby

" Functions

function! FormatJSON()
  :%!python -m json.tool
endfunction

" Show trailing whitespaces
set list
set listchars=tab:▸\ ,trail:¬,nbsp:.,extends:❯,precedes:❮
augroup FileTypes
  autocmd!
  autocmd filetype html,xml set listchars-=tab:▸\
augroup END

" ========== COLORS ==========

hi CursorLine cterm=none ctermbg=black ctermfg=none
hi Pmenu ctermfg=white ctermbg=4
hi PmenuSel ctermfg=white ctermbg=1
hi VertSplit ctermbg=none ctermfg=black
set fillchars=vert:\ 

" ========== SESSION MANAGEMENT ==========

let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_default_to_last = 0
let g:session_autosave = "yes"
let g:session_command_aliases = 1

" ========== BACKUP SETTINGS ==========

set history=1000
set undolevels=1000
set undodir=~/.config/nvim/tmp/undo/
set undofile
set backupdir=~/.config/nvim/tmp/backup/
set directory=~/.config/nvim/tmp/swap/
set backupskip=/tmp/*,/private/tmp/*
set backup
set writebackup
set noswapfile

" ========== CURSOR ==========

" Change cursor line darker on insert
autocmd InsertEnter * hi CursorLine cterm=NONE ctermbg=16
autocmd InsertLeave * hi CursorLine cterm=NONE ctermbg=black

" ========== MAPPINGS ==========

" Set <space> to leader key
let mapleader=" "

" Rotate mappings of ; , and :
" ; to run a command (instead of :)
nnoremap ; :
vnoremap ; :
" , to repeat t or f (instead of ;)
nnoremap , ;
vnoremap , ;
" : to repeat T or F (instead of ,)
nnoremap : ,
vnoremap : ,

" ========== EDITING ==========

"                           Toggle line number
nnoremap <leader>n          :set nonu! nonu?<CR>
"                           Toggle cursorline
nnoremap <leader>c          :set cursorline! cursorline?<CR>
"                           Edit .vimrc
nnoremap <leader>v          :e $MYVIMRC<CR>
"                           Reload .vimrc
nnoremap <leader>V          :so $MYVIMRC<CR>
"                           Open Gundo (Undo Tree)
nnoremap <leader>u          :GundoToggle<CR>
"                           jj or jf is Esc in insert mode
inoremap jj                 <Esc>
inoremap jf                 <Esc>
"                           Copy to system clipboard with y in visual mode
vnoremap y                  "+y
"                           Movement commands in insert mode
inoremap II                 <Esc>I
inoremap AA                 <Esc>A
inoremap OO                 <Esc>O
"                           Edit commands in insert mode

" ========== BUFFERS ==========

"                           Next buffer
nnoremap ≥                  :bn<CR>
"                           Previous buffer
nnoremap ≤                  :bN<CR>
"                           Force close current buffer and maintain window arrangement
nnoremap <leader>x          :bp\|bd! #<CR>

" ========== FILES ==========

"                           Search by file name
nnoremap <leader>o          :FZF<CR>
"                           Save current file
nnoremap <leader>w          :w<CR>
"                           Search working directory
nnoremap <leader>f          :Ag 
nnoremap <leader>t          :AgFile 
"                           Reveal file in NerdTree
nnoremap <leader>r          :NERDTreeFind<CR>
"                           Open NERDTree File Browser
nnoremap <Bslash>           :NERDTreeToggle<CR>

" ========== WINDOWS ==========

"                           Quit while maintaining window arrangement for session
nnoremap <leader>Q          :qa<CR>
"                           Left window
nnoremap <leader>h          <C-w>h
"                           Right window
nnoremap <leader>l          <C-w>l
"                           Up window
nnoremap <leader>k          <C-w>k
"                           Down window
nnoremap <leader>j          <C-w>j
"                           Previous window
nnoremap <leader>;          <C-w><C-p>
"                           Zoom or unzoom window
nnoremap <silent><leader>z  :tab split<CR>
"                           Grow pane horizontally
nnoremap <C-l>              :5winc >\|AirlineRefresh<CR>
"                           Shrink pane horizontally
nnoremap <C-H>              :5winc <\|AirlineRefresh<CR>
"                           Grow pane vertically
nnoremap <C-J>              :5winc +\|AirlineRefresh<CR>
"                           Shrink pane vertically
nnoremap <C-K>              :5winc -\|AirlineRefresh<CR>
"                           Window swapping
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent><leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent><leader>pw :call WindowSwap#DoWindowSwap()<CR>
"nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

" ========== SEARCH ==========

"                           Toggle search highlighing
nnoremap <silent><leader>i  :set hls!<CR>
"                           Search working directory for word under cursor
" nnoremap <C-g>              :Ag <cword><CR>
"                           Search working directory
" nnoremap <C-a>              :Ag 

" ========== GIT ==========

"                           Git status
nnoremap <leader>gs         :Gstatus<CR>
"                           Git commit
nnoremap <leader>gc         :Gcommit<CR>

" ========== SESSIONS ==========

"                           Open vim session (press tab for completion)
nnoremap <leader>so         :OpenSession 
"                           Save vim session (press tab for completion)
nnoremap <leader>ss         :SaveSession 
"                           Delete vim session
nnoremap <leader>sd         :DeleteSession<CR>
"                           Close vim session
nnoremap <leader>sc         :CloseSession<CR>

" ========== PLUGINS ==========

"                           Update plugins to latest version
nnoremap <leader>pi         :PlugInstall<CR>

" ========== EASYMOTION ==========

"                           Jump to anywhere with 2 characters
nmap s                      <Plug>(easymotion-overwin-f2)
"                           EasyMotion search
map  <leader><leader>/      <Plug>(easymotion-sn)
omap <leader><leader>/      <Plug>(easymotion-tn)

" ========== MOVEMENT ==========

" <Option-k> Move up faster
map ˚                       4k
" <Option-j> Move down faster
map ∆                       4j

" Scroll down faster
noremap <C-e>               2<C-e>
" Scroll up faster
noremap <C-y>               2<C-y>

" Scroll down faster
noremap <S-C-e>             5<C-e>
" Scroll up faster
noremap <S-C-y>             5<C-y>

" ========== FZF ===========

let g:fzf_height = 10

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <leader>b :call fzf#run({
  \  'source':  reverse(<sid>buflist()),
  \  'sink':    function('<sid>bufopen'),
  \  'options': '+m',
  \  'down':    len(<sid>buflist()) + 2
  \})<CR>

nnoremap <leader>e :call fzf#run({
  \  'source':  v:oldfiles,
  \  'sink':    'e',
  \  'options': '-m -x +s',
  \  'down':    '40%'})<CR>

let g:signify_vcs_list = [ 'git' ]

" ========== AIRLINE ==========

if !exists("g:airline_symbols")
  let g:airline_symbols = {}
endif

let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

let g:airline_theme                                       = "gruvbox"
let g:airline_powerline_fonts                             = 1
let g:airline#extensions#whitespace#enabled               = 0
let g:airline#extensions#hunks#non_zero_only              = 1    " git gutter
let g:airline#extensions#tabline#enabled                  = 1
let g:airline#extensions#tabline#fnamemod                 = ':t' " filename only
let g:airline#extensions#tabline#show_close_button        = 0
let g:airline#extensions#tabline#show_buffers             = 1
let g:airline#extensions#tabline#tab_nr_type              = 2    " splits and tab number
let g:airline#extensions#tabline#switch_buffers_and_tabs  = 0
let g:airline#extensions#tabline#formatter                = 'unique_tail_improved'
let g:airline_section_b                                   = ''

call airline#parts#define_accent('file', 'red')

" Go to the last cursor location when a file is opened, unless this is a
" git commit (in which case it's annoying)
au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
      \ execute("normal `\"") |
  \ endif

" ========== NEOMAKE ==========

let g:neomake_javascript_enabled_makers = ['jscs']
autocmd! BufWritePost * Neomake

let g:lt_location_list_toggle_map = '<leader>a'
let g:lt_quickfix_list_toggle_map = '<leader>q'
let g:lt_height = 5

" ========== DEOPLETE ==========

let g:deoplete#enable_at_startup = 1
