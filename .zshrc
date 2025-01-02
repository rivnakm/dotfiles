# Skip loading if not an interactive shell
[[ $- == *i* ]] || return

# Disable vim mode (use emacs mode)
bindkey -e

# Enable home/end keys
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# Command history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Bootstrap antigen
if [ ! -d $HOME/.local/share/antigen ]; then
    git clone https://github.com/zsh-users/antigen.git $HOME/.local/share/antigen
fi

# Load antigen
source $HOME/.local/share/antigen/antigen.zsh

# Update antigen
antigen selfupdate
antigen update

# Load zsh plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
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
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=15"
bindkey '^y' autosuggest-accept

# Load starship
eval "$(starship init zsh)"

# User configuration
# Aliases
alias ls="ls --color=auto"
alias l="ls -lah"
alias la="ls -a"
alias rf="rm -rf"
alias ff=fastfetch
alias pf=pfetch
alias nv=nvim
alias snv="EDITOR=nvim sudo -e"
alias nj=ninja

alias csd="chcolors set dark; lookandfeeltool --apply org.kde.breezedark.desktop"
alias csl="chcolors set light; lookandfeeltool --apply org.kde.breeze.desktop"

alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gpu="git push"
alias gpl="git pull"
alias gd="git diff"
alias gds="git diff --staged"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

fastfetch

echo -e "\n"
projfetch --compact --max-width 72 $HOME/Code

