# Justin's dotfiles

## Installation

1. `~ $ git clone https://github.com/wyne/dotfiles.git`
2. Stow a config. ex: `stow vim`, `stow zsh`, `stow slate`

## zsh

![Screenshot](http://i.imgur.com/GSn5vA7.png)

The following commands rely heavily on [fasd](https://github.com/clvv/fasd) and [fzf](https://github.com/junegunn/fzf).
* **v \<substr\>** - open recent file containing _substr_ with vim.
* **vv \<substr\>** - open recent file containing _substr_ with vim. _(interactive selection)_
* **j** - cd to prev dir. (`cd -`)
* **j \<substr\>** - cd to recent directory containing _substr_.
* **jj \<substr\>** - cd to recent directory containing _substr_. _(interactive selection)_
* **fbr** - git checkout branch (local only). _(interactive selection)_
* **fbrr** - git checkout branch (include remotes). _(interactive selection)_


## vim

![Screenshot](http://i.imgur.com/bY1Mw1S.png)

#### General
* **;** is remapped to **:** for commands so you don't have to press shift :)
* **\<space\>** is the leader key
* **\<space\> w** - save current file
* **\<space\> x** - close current buffer while maintaining window arrangment
* **\<tab\>** - next buffer
* **\<shift\> \<tab\>** - previous buffer
* **\<space\> q** - quit while preserving window arrangements
* **\\** - Open file browser (NERDTree)
* **\<space\> o** - Open file selector. Supports fuzzy matching like "TMF" for "TheMainFile.scala"
  * **\<Ctrl-f\>** - Toggle between buffers, files, and most recently used files modes
  * **\<Ctrl-r\>** - Toggle regex searching
*  **\<Ctrl-n\>** - Select next occurence of word
  * Use normal mode operations like **c**, **d**, etc
* **\<space\> u** - Open undo tree (Gundo)

#### Sessions
* **\<space\> ss {name}** - save your current session to preserve open files, etc.
* **\<space\> so** - restore a session you saved with _ss_. Use \<tab\> to iterate through options.

#### Vimrc
* **\<space\> v** - Edit .vimrc
* **\<space\> V** - Reload .vimrc
