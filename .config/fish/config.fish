# WSL
if test "$PWD" = "/mnt/c/Users/Michael"
    cd $HOME
end

# Add cargo and go to path
set PATH $PATH $HOME/.cargo/bin $HOME/go/bin

set -g fish_greeting

set -x EDITOR nvim
set -x VISUAL code
set -x LANG en_US.UTF-8

alias ls "ls --color=auto"
alias l "ls -lah"
alias rf "rm -rf"
alias nf neofetch
alias pf pfetch
alias par paru
alias pin "paru -S"
alias prm "paru -R"
alias por "paru -Qtdq | paru -Rns -"

set -x PF_INFO "ascii title os kernel shell editor pkgs memory"
VISUAL=$EDITOR pfetch

# activate starship prompt
starship init fish | source