# Fish configuration
set fish_greeting
set fish_color_autosuggestion gray

# Environment variables
set -x PATH $PATH "$HOME/.local/bin"
set -x LANG "en_US.UTF-8"
set -x TZ "America/New_York"
set -x EDITOR "nvim"
set -x TOOLBOX_SHELL (which fish)

# C/C++ environment
set -x CC clang
set -x CXX clang++
set -x CMAKE_GENERATOR Ninja

# Cargo environment
set -x PATH $PATH "$HOME/.cargo/bin" 

# vcpkg environment
set -x VCPKG_ROOT "$HOME/.local/share/vcpkg"
set -x PATH $PATH $VCPKG_ROOT

# dotnet CLI environment
set -x DOTNET_NOLOGO true
set -x PATH $PATH "$HOME/.dotnet/tools"

# JetBrains Toolbox
set -x PATH $PATH "$HOME/.local/share/JetBrains/Toolbox/scripts"

# opam configuration
test -r '/home/michael/.opam/opam-init/init.fish' && source '/home/michael/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true

if status is-interactive
    # Aliases
    alias ls="ls --color=auto"
    alias l="ls -lah"
    alias la="ls -a"
    alias rf="rm -rf"
    alias ff=fastfetch
    alias pf=pfetch
    alias nv=nvim
    alias snv="EDITOR=nvim sudo -e"
    alias na=ninja
    alias zj=zellij

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

    starship init fish | source

    fastfetch

    echo -e "\n"
    projfetch --compact --max-width 72 $HOME/Code
end


