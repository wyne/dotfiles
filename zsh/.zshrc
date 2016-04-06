# Path to your oh-my-zsh installation.
export ZSH=/Users/Justin/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
#ZSH_THEME="agnoster"
ZSH_THEME="pure"

# Enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty. This makes repository status
# check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(bundler osx rake ruby)
plugins+=(zsh-completions zsh-syntax-highlighting)
autoload -U compinit && compinit

# ===== User configuration =====
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/Justin/.fzf/bin"
# export MANPATH="/usr/local/man:$MANPATH"
export PATH="/Applications/RubyMine.app/Contents/MacOS/:$PATH"

# ===== Oh my ZSH =====
source $ZSH/oh-my-zsh.sh

# ===== Aliases =====
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias ll="ls -la"
alias vi="nvim"
alias npm-exec='PATH=$(npm bin):$PATH'
alias gas='git add app/assets/'
alias clock='~/workspace/tty-clock/tty-clock -tc'

# Git
alias g='git'
alias ga='git add -p'
alias gaa='git add -i'
alias gr='git reset -p'
alias grm='git rm'

alias gf='git fetch'
alias gu='git pull'
alias ghu='git pull hy'
alias ghp='git push hy'

alias gs='git status --short'
alias gss='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gdisc='git discard'

alias gp='git push'
alias gpn='git push --set-upstream origin `git rev-parse --abbrev-ref HEAD`'
alias gcl='git clone'
alias gch='git checkout'
alias gco='git checkout -p'
alias gbr='git branch'
alias gbrd='git branch -d'
alias gl='git log --no-merges'
alias gdl='git log --decorate=short --oneline --color=always develop --not prod/master'
alias gfix='git diff --name-only | uniq | xargs nvim'

function gc() { # gc commit message
  args=$@
  git commit -m "$args"
}

# ========== FASD
eval "$(fasd --init auto)"

# Defaults
# alias a='fasd -a'        # any
# alias s='fasd -si'       # show / search / select
# alias d='fasd -d'        # directory
# alias f='fasd -f'        # file
# alias sd='fasd -sid'     # interactive directory selection
# alias sf='fasd -sif'     # interactive file selection
# alias z='fasd_cd -d'     # cd, same functionality as j in autojump
# alias zz='fasd_cd -d -i' # cd with interactive selection
alias v='f -e nvim'
#vv interactive search defined in fzf

# ========== FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.custom-bindings.fzf ] && source ~/.custom-bindings.fzf

alias zz='fz'
# j - same as z, but if no arguments, jump to previous directory
j() {
  if [ "$#" -gt 0 ]; then
    fasd_cd -d $1
  else
    cd -
  fi
}
alias jj='fz'

# Pretty print json
alias json='python -m json.tool'

# iTerm 2 Shell Integration
test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="/Users/justin/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export EDITOR=/usr/local/bin/nvim
