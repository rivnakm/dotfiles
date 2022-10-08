# WSL
if test "$PWD" = "/mnt/c/Users/Michael"
    cd $HOME
end

# Add cargo and go to path
set PATH $PATH $HOME/.local/bin $HOME/.cargo/bin $HOME/go/bin

set -g fish_greeting

set -x EDITOR helix
set -x LANG en_US.UTF-8

alias ls "ls --color=auto"
alias l "ls -lah"
alias la "ls -a"
alias rf "rm -rf"
alias nf neofetch
alias pf pfetch
alias par paru
alias pin "paru -S"
alias prm "paru -R"
alias por "paru -Qtdq | paru -Rns -"
alias hx helix
alias shx "EDITOR=helix sudo -e"

fish_vi_key_bindings insert

set -x PF_INFO "ascii title os kernel shell editor pkgs memory"
pfetch

# activate starship prompt
starship init fish | source
