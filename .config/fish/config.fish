# Fish configuration
set fish_greeting
set fish_color_autosuggestion gray
set -x fish_function_path $fish_function_path "$HOME/.local/share/fish/user_functions.d"

# Environment variables
set -x PATH $PATH "$HOME/.local/bin"
set -x LANG "en_US.UTF-8"
set -x TZ "America/New_York"
set -x EDITOR "nvim"
set -x TOOLBOX_SHELL (which fish)
set -x GPG_TTY (tty)
set -x MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

# C/C++ environment
set -x CC clang
set -x CXX clang++
set -x CMAKE_GENERATOR Ninja

# Cargo environment
set -x PATH $PATH "$HOME/.cargo/bin"

# Zig environment
set -x PATH $PATH "$HOME/.local/share/zigup"
# zigup uses ~/zig by default, which is messy
# https://github.com/marler8997/zigup/issues/148
alias zigup="zigup --install-dir $HOME/.zig"

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
    alias ls="eza \
        --group \
        --long \
        --octal-permissions \
        --git \
        --icons auto \
        --time-style long-iso \
        --header \
        --smart-group"
    alias l="ls --all"
    alias lr="ls --all --total-size"

    alias rf="rm -rf"
    alias ff=fastfetch
    alias nv=nvim
    alias snv="EDITOR=nvim sudo -e"
    alias na=ninja
    alias zj=zellij
    alias cat=bat

    alias csd="chcolors set dark"
    alias csl="chcolors set light"

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
end


