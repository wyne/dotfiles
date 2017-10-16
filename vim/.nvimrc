" ========== Fresh Start Steps ==========
" 1. Install neovim
"   https://github.com/neovim/homebrew-neovim/blob/master/README.md
"
" 2. install python support
"   $ pip install --user neovim
"   :UpdateRemotePlugins
"
" 3. Install patched fonts - Optional
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

" python
" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
if has('nvim')
  let g:python_host_prog = glob('~/.pyenv/versions/neovim2/bin/python')
  let g:python3_host_prog = glob('~/.pyenv/versions/neovim3/bin/python')
endif

" plugins

if has('nvim')
  call plug#begin('~/.config/nvim/bundle')
else
  call plug#begin('~/.config/vim/bundle')
endif

" core plugins
if !has('nvim')
  Plug 'tpope/vim-sensible'               " Sensible defaults
endif

Plug 'flazz/vim-colorschemes'           " Set of color schemes
Plug 'scrooloose/nerdtree'              " Directory browsing
Plug 'tpope/vim-fugitive'               " Git commands
Plug 'tpope/vim-rhubarb'                " Github support for fugitive
Plug 'tpope/vim-surround'               " Vim-surround
Plug 'tpope/vim-commentary'             " Vim-commentary
Plug 'morhetz/gruvbox'                  " Color scheme
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" other plugins

Plug 'kshenoy/vim-signature'            " Mark gutter
Plug 'Shougo/deoplete.nvim'             " Autocomplete for nvim
Plug 'Valloric/ListToggle'              " Toggle location list
Plug 'benekastah/neomake'               " Syntax checking
Plug 'easymotion/vim-easymotion'        " Fast movement
Plug 'godlygeek/tabular'                " Alignment
Plug 'henrik/vim-indexed-search'        " Show N of M matches during search
Plug 'junegunn/goyo.vim'                " Markdown
Plug 'mhinz/vim-signify'                " Git gutter
Plug 'mustache/vim-mustache-handlebars' " Mustache
Plug 'sjl/gundo.vim'                    " Undo Tree
Plug 'terryma/vim-expand-region'        " Expand regions
Plug 'tpope/vim-dispatch'               " Tmux integration
Plug 'tpope/vim-unimpaired'             " Move text
Plug 'vim-airline/vim-airline'          " Status bar
Plug 'wellle/targets.vim'               " Additional text objects
Plug 'wesQ3/vim-windowswap'             " Window swapping
Plug 'xolox/vim-misc'                   " Requirement for session management
Plug 'xolox/vim-session'                " Session management
Plug 'yssl/QFEnter'                     " Choose window for quick fix open
Plug 'vim-ruby/vim-ruby'                " Ruby
Plug 'jeetsukumaran/vim-buffergator'    " Buffer management
Plug 'michaeljsmith/vim-indent-object'  " Indent text object
Plug 'radenling/vim-dispatch-neovim'    " Neovim dispatch
Plug 'janko-m/vim-test'                 " Testing
Plug 'kassio/neoterm'                   " Testing
Plug 'kchmck/vim-coffee-script'         " Coffeescript
Plug 'junegunn/gv.vim'                  " Git commit browser
Plug 'roman/golden-ratio'               " Window sizing
Plug 'tpope/vim-speeddating'            " Date inc/dec
Plug 'gregsexton/gitv'                  " Gitk for vim
Plug 'Townk/vim-autoclose'              " Auto close parens
Plug 'vimwiki/vimwiki'                  " Wiki for vim
Plug 'itchyny/calendar.vim'             " Calendar
Plug 'vim-scripts/dbext.vim'            " Database plugin
Plug 'joshdick/onedark.vim'             " One Dark themes
Plug 'amadeus/vim-mjml'                 " mjml support

call plug#end()

" ========== GENERAL CONFIG ==========

syntax on
set termguicolors

set background=dark
set nowrap                               " Don't wrap lines
set ruler                                " Show cursor line and column in status bar
set hidden
set nocursorline                         " Disable highlight current line
set re=1                                 " Fixes slow cursorline
set tabstop=2                            " A tab is four spaces
set smarttab                             " Insert tabs on the start of a line according to shiftwidth, not tabstop
set autoindent                           " Always set autoindenting on
set copyindent                           " Copy the previous indentation on autoindenting
set shiftwidth=2                         " Number of spaces to use forautoindenting
set shiftround                           " Use multiple of shiftwidth when indenting with '<' and '>'
set showmatch                            " Set show matching parenthesis
set ignorecase                           " Ignore case when searching
set smartcase                            " Ignore case if search pattern is all lowercase
set incsearch                            " Show search matches as you type
set backspace=indent,eol,start           " Allow backspacing over everything in insert mode
set wildignore=*.swp,*.bak,*.pyc,*.class
set pastetoggle=<f2>
set scrolloff=2                          " Start scrolling when 2 lines from edge
set sidescroll=1                         " Scroll horizontally by 1 column
set sidescrolloff=2                      " Start scrolling horizontally when 2 lines from edge
set colorcolumn=100                      " Column ruler at 100 characters
set number
set nofoldenable                         " Disable folding
set nolazyredraw                         " Disable lazyredraw
set mouse=a
set expandtab                            " Use spaces intead of tabs

if has("gui_macvim")
  set guifont=SauceCodePowerline-Regular:h16
  set guioptions-=rlRL
endif

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

" hi CursorLine cterm=none ctermbg=black ctermfg=none
" hi ColorColumn guibg=Grey10
" hi Pmenu ctermfg=white ctermbg=4
" hi PmenuSel ctermfg=white ctermbg=1
" hi VertSplit ctermbg=none ctermfg=black
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

" Change cursor shape per mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

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

" vimr workaround - https://github.com/qvacua/vimr/issues/492
nnoremap <C-6> <C-^>

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
"                           Copy to system clipboard with y in visual mode
vnoremap y                  "+y
"                           Toggle presentation mode
nnoremap <leader>p          :silent! windo SignifyToggle<CR>:silent! windo SignatureToggleSigns<CR>:silent! windo set nonu! nonu?<CR>
"                           Yank current file path
nnoremap <leader>F          :let @* = expand("%")<CR>
"                           Run current file as teset
nnoremap <leader>t          :T bin/rake test %:h/%:t<CR>
let g:neoterm_position = "horizontal"

" Go to the last cursor location when a file is opened, unless this is a
" git commit (in which case it's annoying)
au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
      \ execute("normal `\"") |
  \ endif

" ========== BUFFERS ==========

"                           Prevent default buffergator mappings
let g:buffergator_suppress_keymaps = 1
"                           Buffer manager
nnoremap <leader>B          :BuffergatorToggle<CR>

"                           Force close current buffer and maintain window arrangement
nnoremap <leader>x          :bp\|bd! #<CR>

" ========== FILES ==========

"                           Save current file
nnoremap <leader>w          :w<CR>
"                           Save current file (sudo hack)
nnoremap <leader>W          :w !sudo tee > /dev/null %<CR>
"                           Reveal file in NERDTree
nnoremap <leader>r          :NERDTreeFind<CR>
"                           Focus NERDTree
nnoremap <leader>R          :NERDTreeFocus<CR>
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
nnoremap <C-l>              :5winc ><CR>
"                           Shrink pane horizontally
nnoremap <C-h>              :5winc <<CR>
"                           Grow pane vertically
nnoremap <C-j>              :5winc +<CR>
"                           Shrink pane vertically
nnoremap <C-k>              :5winc -<CR>
"                           Refresh Airline (for after a winc command above)
nnoremap <C-m>              :AirlineRefresh<CR>
"                           Window swapping
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent><leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent><leader>pw :call WindowSwap#DoWindowSwap()<CR>
"nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

" Golden Ratio (useful when using laptop screen only
let g:golden_ratio_autocommand = 0 " Disable by default, enable with :GoldenRatioToggle

" ========== SEARCH ==========

"                           Toggle search highlighing
nnoremap <silent><leader>i  :set hls!<CR>
"                           Search working directory
nnoremap <leader>ff         :Ag 

" ========== GIT ==========

"                           Git status
nnoremap <leader>gs         :Gstatus<CR>
"                           Git commit
nnoremap <leader>gc         :Gcommit<CR>

" ========== SESSIONS ==========

"                           Open vim session (press tab for completion)
nnoremap <leader>so         :OpenSession 
"                           Open vim session (press tab for completion)
nnoremap <leader>sO         :OpenSession! 
"                           Save vim session (press tab for completion)
nnoremap <leader>ss         :SaveSession 
"                           Delete vim session
nnoremap <leader>sd         :DeleteSession<CR>
"                           Close vim session
nnoremap <leader>sc         :CloseSession<CR>

" ========== PLUGINS ==========

"                           Update plugins to latest version
nnoremap <leader>pi         :PlugInstall<CR>
"                           Update plugins to latest version
nnoremap <leader>pc         :PlugClean<CR>
"                           Update plugins to latest version
nnoremap <leader>pu         :PlugUpdate<CR>

" ========== VIMWIKI ==========

map <Leader>tt              <Plug>VimwikiToggleListItem

" ========== CALENDAR ==========

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" ========== TERMINAL ==========

if has('nvim')
  tnoremap <leader><Esc>      <C-\><C-n>
endif

" ========== EASYMOTION ==========

"                           Jump to anywhere with 2 characters
nmap s                      <Plug>(easymotion-overwin-f)
"                           EasyMotion search
map  <leader><leader>/      <Plug>(easymotion-sn)
omap <leader><leader>/      <Plug>(easymotion-tn)

" ========== MOVEMENT ==========

" <Option-k> Move up faster
map ˚                       4k
map <M-˚>                   4k
" <Option-j> Move down faster
map ∆                       4j
map <M-∆>                   4j

" Scroll down faster
noremap <C-e>               2<C-e>
" Scroll up faster
noremap <C-y>               2<C-y>

" Scroll down faster
noremap <S-C-e>             5<C-e>
" Scroll up faster
noremap <S-C-y>             5<C-y>

" ========== Multiple Cursor Replacement ========
" http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/

let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"

nnoremap cn *``cgn
nnoremap cN *``cgN

vnoremap <expr> cn g:mc . "``cgn"
vnoremap <expr> cN g:mc . "``cgN"

function! SetupCR()
  nnoremap <Enter> :nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z
endfunction

nnoremap cq :call SetupCR()<CR>*``qz
nnoremap cQ :call SetupCR()<CR>#``qz

vnoremap <expr> cq ":\<C-u>call SetupCR()\<CR>" . "gv" . g:mc . "``qz"
vnoremap <expr> cQ ":\<C-u>call SetupCR()\<CR>" . "gv" . substitute(g:mc, '/', '?', 'g') . "``qz"

" ========== FZF ===========

let g:fzf_layout = { 'window': 'enew' }
let g:fzf_buffers_jump = 1
let g:fzf_height = 10

" CTRL-A CTRL-Q to select all and build quickfix list
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_COMMAND = 'ag --hidden --skip-vcs-ignores --ignore .git -l -g ""'

"                           Search open buffers
nnoremap <leader>fb         :Buffers<CR>
"                           Search buffer commits
nnoremap <leader>fc         :BCommits<CR>
"                           Search commits
nnoremap <leader>fC         :Commits<CR>
"                           Search changed files
nnoremap <leader>fd         :GFiles?<CR>
"                           Search v:oldfiles and open buffers
nnoremap <leader>fe         :History<CR>
"                           Search all tags
nnoremap <leader>fe         :History<CR>
"                           Search lines in current buffer
nnoremap <leader>fl         :BLines<CR>
"                           Search lines in loaded buffers
nnoremap <leader>fL         :Lines<CR>
"                           Search marks
nnoremap <leader>fm         :Marks<CR>
"                           Search marks
nnoremap <leader>fM         :Maps<CR>
"                           Search git files
nnoremap <leader>fo         :GFiles<CR>
"                           Search all files
nnoremap <leader>fO         :Files<CR>
"                           Search buffer tags
nnoremap <leader>ft         :BTags<CR>
"                           Search all tags
nnoremap <leader>fT         :Tags<CR>
"                           Search windows
nnoremap <leader>fw         :Windows<CR>

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

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

let g:airline_theme                                       = "onedark"
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
let g:airline_section_c                                   = '%t'

" ========== NEOMAKE ==========

let g:neomake_javascript_enabled_makers = ['jscs']
autocmd! BufWritePost * Neomake

let g:lt_location_list_toggle_map = '<leader>a'
let g:lt_quickfix_list_toggle_map = '<leader>q'
let g:lt_height = 5

" ========== DEOPLETE ==========

let g:deoplete#disable_auto_complete = 1
let g:deoplete#enable_at_startup = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

colorscheme onedark
