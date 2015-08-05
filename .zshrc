# Path to your oh-my-zsh installation.
export ZSH=/Users/Justin/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty. This makes repository status 
# check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git bundler osx rake ruby)

# ===== User configuration =====
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/Justin/.fzf/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# ===== Oh my ZSH =====
source $ZSH/oh-my-zsh.sh

# ===== Aliases =====
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias ll="ls -la"
