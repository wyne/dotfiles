" ========== Fresh Start Steps ==========
" 1. Make sure to use vim 7.4+ with lua support
"   brew install vim --with-lua
"
" 2. Prepare directory for backups
"   mkdir -p ~/.vim/tmp/swap ~/.vim/tmp/backup ~/.vim/tmp/undo
"
" 3. Install Plug
"   https://github.com/junegunn/vim-plug
"
" 4. Install Packages
"   vim +PluginInstall +qall
"
" 5. Install patched fonts
"   http://powerline.readthedocs.org/en/latest/installation/osx.html
"   https://github.com/powerline/fonts.git
"   ./install.sh
" 6. pip install --user neovim

" ========== SETUP ==========
set nocompatible

" ==== PLUG ====

" Auto install
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Setup
call plug#begin('~/.vim/bundle')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" core plugins

Plug 'flazz/vim-colorschemes'         " Set of color schemes http://bytefluent.com/vivify/
Plug 'kien/ctrlp.vim'                 " File search
Plug 'scrooloose/nerdtree'            " Directory browsing
Plug 'tpope/vim-sensible'             " Sensible defaults
Plug 'tpope/vim-fugitive'             " Git commands
Plug 'tpope/vim-surround'             " vim-surround
Plug 'tpope/vim-commentary'           " vim-commentary
Plug 'morhetz/gruvbox'                " color scheme

" other plugins

Plug 'bling/vim-airline'                " Status bar
Plug 'edma2/vim-pants'                  " Pants plugin
Plug 'henrik/vim-indexed-search'        " Show N of M matches during search
Plug 'mustache/vim-mustache-handlebars' " Mustache
Plug 'rking/ag.vim'                     " Searching
Plug 'sjl/gundo.vim'                    " Undo Tree
Plug 'simnalamburt/vim-mundo'           " Undo Tree
Plug 'mbbill/undotree'                  " Undo Tree
Plug 'solarnz/thrift.vim'               " Thrift syntax
Plug 'terryma/vim-multiple-cursors'     " Sublime style repeat word select
Plug 'tpope/vim-dispatch'               " Tmux integration
Plug 'wellle/targets.vim'               " Additional text objects
Plug 'wesQ3/vim-windowswap'             " Window swapping
Plug 'xolox/vim-session'                " Session management
Plug 'tpope/vim-unimpaired'             " Move text
Plug 'xolox/vim-misc'                   " Requirement for session management
Plug 'junegunn/goyo.vim'                " Markdown
Plug 'scrooloose/syntastic'             " Syntax checking
Plug 'osyo-manga/vim-over'              " Search and replace preview
Plug 'terryma/vim-expand-region'        " expand regions
Plug 'Shougo/deoplete.nvim'             " autocomplete for nvim
Plug 'kchmck/vim-coffee-script'         " coffeescript
Plug 'godlygeek/tabular'                " Alignment
Plug 'easymotion/vim-easymotion'        " Fast movement

call plug#end()

" Use deoplete.
let g:deoplete#enable_at_startup = 1

colorscheme gruvbox
set background=dark

" ========== AIRLINE ==========
if !exists("g:airline_symbols")
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts=1
let g:airline#extensions#branch#empty_message  =  "No SCM"
let g:airline#extensions#whitespace#enabled    =  0
let g:airline#extensions#syntastic#enabled     =  1
let g:airline#extensions#tabline#enabled       =  1
let g:airline#extensions#tabline#tab_nr_type   =  2   " tab number
let g:airline#extensions#tabline#fnamemod      = ':t' " filename only
let g:airline#extensions#hunks#non_zero_only   =  1   " git gutter
" Prefix mode with current time
" let g:airline_section_b = airline#section#create(['%{strftime("%b %d %H:%M")} '])
let g:airline_theme="gruvbox"

" ========== GENERAL CONFIG ==========
syntax on
set nowrap        " don't wrap lines
set ruler         " show cursor line and column in status bar
set hidden
set cursorline    " highlight current line
set re=1          " fixes slow cursorline
set expandtab     " use spaces intead of tabs
set tabstop=2     " a tab is four spaces
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=2  " number of spaces to use forautoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase
set incsearch     " show search matches as you type
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set wildignore=*.swp,*.bak,*.pyc,*.class
set pastetoggle=<f2>
set scrolloff=2     " start scrolling when 2 lines from edge
set sidescroll=1    " scroll horizontally by 1 column
set sidescrolloff=2 " start scrolling horizontally when 2 lines from edge

let NERDTreeShowHidden=1

" nnoremap <leader><leader>   <C-w><C-p>
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

set number

" Set file types
au BufRead,BufNewFile *.mustache setfiletype mustache
au BufRead,BufNewFile *.thrift set syntax=thrift
au BufRead,BufNewFile *.aurora set syntax=ruby
au BufRead,BufNewFile *.json.jbuilder set syntax=ruby

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
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_default_to_last = 0
let g:session_autosave = "yes"
let g:session_command_aliases = 1

" ========== BACKUP SETTINGS ==========
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

" ========== CURSOR ==========
" change cursor shape in different modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" ========== LEADER ==========
" Set <space> to leader key
let mapleader=" "

" ========== EDITING ==========
"                           Toggle line number
nnoremap <leader>n          :set rnu! rnu?<CR>
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
inoremap CC                 <Esc>C
inoremap SS                 <Esc>S
inoremap DD                 <Esc>dd
inoremap UU                 <Esc>u

" ========== BUFFERS ==========
"                           Next buffer
nnoremap ≥                 :bn<CR>
"                           Previous buffer
nnoremap ≤                 :bN<CR>
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
nnoremap <leader>q          :qa<CR>
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
nnoremap <C-l>              :5winc ><CR>
nnoremap S-C-L            :winc ><CR>
"                           Shrink pane horizontally
" infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
" tic $TERM.ti
nnoremap <C-H>              :5winc <<CR>
nnoremap S-C-H            :winc <<CR>
"                           Grow pane vertically
nnoremap <C-J>              :5winc +<CR>
nnoremap S-C-J            :winc +<CR>
"                           Shrink pane vertically
nnoremap <C-K>              :5winc -<CR>
nnoremap S-C-K            :winc -<CR>
"                           Window swapping
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent><leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent><leader>pw :call WindowSwap#DoWindowSwap()<CR>
"nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

" ========== SEARCH ==========
"                           Toggle search highlighing
nnoremap <silent><leader>i  :set hls!<CR>
"                           Search working directory for word under cursor
nnoremap <C-g>              :Ag <cword><CR>
"                           Search working directory
nnoremap <C-a>              :Ag 

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

" <Option-k> Move up faster
map ˚ 4k
" <Option-j> Move down faster
map ∆ 4j

" Scroll down faster
noremap <C-e> 2<C-e>
" Scroll up faster
noremap <C-y> 2<C-y>

" Scroll down faster
noremap <S-C-e> 5<C-e>
" Scroll up faster
noremap <S-C-y> 5<C-y>

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" === FZF ====
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent><leader>b :call fzf#run({
\  'source':  reverse(<sid>buflist()),
\  'sink':    function('<sid>bufopen'),
\  'options': '+m',
\  'down':    len(<sid>buflist()) + 2
\})<CR>



" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"let g:syntastic_javascript_checkers = ['jscs']
