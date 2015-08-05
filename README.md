# Justin's dotfiles

##
Installation

1. Clone Repo
2. stow vim, stow zsh, stow slate

## vim

![Screenshot](http://i.imgur.com/bY1Mw1S.png)

### Highlights:

#### General Key Bindings
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
