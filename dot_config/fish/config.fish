# Fish configuration
set fish_greeting

# Environment variables
fish_add_path "$HOME/.local/bin"
set -x LANG "en_US.UTF-8"
set -x TZ "America/New_York"
set -x EDITOR "nvim"
set -x TOOLBOX_SHELL (which fish)
set -x GPG_TTY (tty)
set -x MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -lman'"
set -x DOCKER_HOST "unix://$XDG_RUNTIME_DIR/podman/podman.sock"

# C/C++ environment
set -x CC clang
set -x CXX clang++
set -x FC flang
set -x CMAKE_GENERATOR Ninja

# Cargo environment
fish_add_path "$HOME/.cargo/bin"

# Zig environment
set -x ZVM_INSTALL "$HOME/.zvm/self"
fish_add_path "$ZVM_INSTALL"
fish_add_path "$HOME/.zvm/bin"

# vcpkg environment
set -x VCPKG_ROOT "$HOME/.local/share/vcpkg"
fish_add_path $VCPKG_ROOT

# dotnet CLI environment
set -x DOTNET_NOLOGO true
fish_add_path "$HOME/.dotnet/tools"

# JetBrains Toolbox
fish_add_path "$HOME/.local/share/JetBrains/Toolbox/scripts"

# opam configuration
test -r '/home/michael/.opam/opam-init/init.fish' && source '/home/michael/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true

# pnpm
set -x PNPM_HOME "/home/michael/.local/share/pnpm"
fish_add_path "$PNPM_HOME"

# fzf.fish configuration
set fzf_diff_highlighter delta --paging=never --width=20

if status is-interactive
    # Modus Vivendi color theme
    set -l foreground ffffff
    set -l selection 7030af
    set -l comment 989898
    set -l red ff5f59
    set -l orange fec43f
    set -l yellow d0bc00
    set -l green 44bc44
    set -l purple b6a0ff
    set -l cyan 00d3d0
    set -l pink feacd0

    set -g fish_color_normal $foreground
    set -g fish_color_command $cyan
    set -g fish_color_keyword $pink
    set -g fish_color_quote $yellow
    set -g fish_color_redirection $foreground
    set -g fish_color_end $orange
    set -g fish_color_option $pink
    set -g fish_color_error $red
    set -g fish_color_param $purple
    set -g fish_color_comment $comment
    set -g fish_color_selection --background=$selection
    set -g fish_color_search_match --background=$selection
    set -g fish_color_operator $green
    set -g fish_color_escape $pink
    set -g fish_color_autosuggestion $comment

    set -g fish_pager_color_progress $comment
    set -g fish_pager_color_prefix $cyan
    set -g fish_pager_color_completion $foreground
    set -g fish_pager_color_description $comment
    set -g fish_pager_color_selected_background --background=$selection

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

    alias sudo="sudo-rs"
    alias rf="rm -rf"
    alias ff=fastfetch
    alias projfetch="projfetch --max-width 80"
    alias pf=projfetch
    alias of=onefetch
    alias nv=nvim
    alias snv="EDITOR=nvim sudo -e"
    alias na=ninja
    alias zj=zellij
    alias cat=bat
    alias du=dust
    alias diff=delta
    alias bw=bitwise
    alias j=just
    alias ya=yazi
    alias oc=opencode
    alias code="code-insiders"
    alias chm=chezmoi

    alias gs="git status"
    alias ga="git add"
    alias gc="git commit -m"
    alias gpu="git push"
    alias gpl="git pull"
    alias gd="git diff"
    alias gds="git diff --staged"

    alias exr="exercism"
    alias ext="exercism test"
    alias exs="exercism submit"

    alias dni="sudo dnf install"
    alias dns="dnf search"

    alias ..="cd .."
    alias ...="cd ../.."
    alias ....="cd ../../.."

    starship init fish | source
    zoxide init fish | source
    direnv hook fish | source

    test -r '/home/michael/.opam/opam-init/init.fish' && source '/home/michael/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
end
