if [ "$PWD" = "/mnt/c/Users/Michael" ]; then
    cd $HOME
fi

export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin

# Disable vim mode (use emacs mode)
bindkey -e

# Enable home/end keys
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# Command history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Load antigen
source $HOME/.local/share/antigen/antigen.zsh

# Load zsh plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle ptavares/zsh-direnv@main
antigen bundle MenkeTechnologies/zsh-cargo-completion
antigen bundle MenkeTechnologies/zsh-dotnet-completion
antigen bundle sudosubin/zsh-github-cli
antigen bundle sunlei/zsh-ssh

# Apply the configuration
antigen apply

# zsh-history-substring-search configuration
bindkey '^[[A' history-substring-search-up # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=0

# zsh-autosuggestions configuration
bindkey '^y' autosuggest-accept

# Load starship
eval "$(starship init zsh)"

# User configuration

# Environment variables
export LANG=en_US.UTF-8
export TZ=America/New_York
export TOOLBOX_SHELL=$(which zsh)

# Use clang as default C/C++ compiler
export CC=clang
export CXX=clang++
export CMAKE_GENERATOR=Ninja
export EDITOR=nvim

alias ls="ls --color=auto"
alias l="ls -lah"
alias la="ls -a"
alias rf="rm -rf"
alias ff=fastfetch
alias pf=pfetch
alias nv=nvim
alias snv="EDITOR=nvim sudo -e"
alias nj=ninja

alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gpu="git push"
alias gpl="git pull"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

export PF_INFO="ascii title os kernel shell de editor pkgs memory palette"
pfetch
