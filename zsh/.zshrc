# Path to your oh-my-zsh installation.
export ZSH=/Users/Justin/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
#ZSH_THEME="agnoster"
ZSH_THEME="robbyrussell"

# Enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty. This makes repository status
# check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git bundler osx rake ruby)

# FASD
eval "$(fasd --init auto)"
# defaults: https://github.com/clvv/fasd

# ===== User configuration =====
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/Justin/.fzf/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# ===== Oh my ZSH =====
source $ZSH/oh-my-zsh.sh

# ===== Aliases =====
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias ll="ls -la"
alias v="nvim"
alias vi="nvim"

# Git
alias g='git'
alias ga='git add -i'
alias gr='git reset -p'
alias grm='git rm'

alias gf='git fetch'
alias gu='git pull'
alias ghu='git pull hy'
alias ghp='git push hy'

alias gs='git status --short'
alias gd='git diff'
alias gds='git diff --staged'
alias gdisc='git discard'

alias gp='git push'
alias gcl='git clone'
alias gch='git checkout'
alias gco='git checkout -p'
alias gbr='git branch'
alias gbrd='git branch -D'
alias gl='git log --no-merges'

# gc my commit message
function gc() {
  args=$@
  git commit -m "$args"
}

# Pretty print json
alias json='python -m json.tool'

# iTerm 2 Shell Integration
test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# Disable git
#function git_prompt_info() {
#  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
#}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
