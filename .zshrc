if [ "$PWD" = "/mnt/c/Users/Michael" ]; then
    cd $HOME
fi

# If you come from bash you might have to change your $PATH.
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="" # using starship for theme

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    alias-finder
    colored-man-pages
    command-not-found
    direnv
    fzf
    extract
    rsync
    rust
    starship
    sudo
    systemd
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Environment variables
export LANG=en_US.UTF-8
export EDITOR=nvim
export TZ=America/New_York
export PF_INFO="ascii title os kernel shell editor pkgs memory palette"
export TOOLBOX_SHELL=$(which zsh)

# Use clang as default C/C++ compiler
export CC=clang
export CXX=clang++
export CMAKE_GENERATOR=Ninja

alias ls="ls --color=auto"
alias l="ls -lah"
alias la="ls -a"
alias rf="rm -rf"
alias ff=fastfetch
alias pf=pfetch
alias par=paru
alias pin="paru -S"
alias prm="paru -R"
alias por="paru -Qtdq | paru -Rns -"
alias dnfi="sudo dnf install"
alias dnfr="sudo dnf remove"
alias dnfu="sudo dnf upgrade"
alias nv=nvim
alias snv="EDITOR=nvim sudo -e"
alias mc=micro
alias smc="EDITOR=micro sudo -e"
alias gs="git status"
alias gpu="git push"
alias gpl="git pull"
alias ga="git add"
alias gc="git commit -m"
alias nj=ninja

# This is a bit silly but it's fun
# I use arch and gentoo primarily so most of these checks never happen
function upg {
    if grep -qi "Arch" /etc/os-release; then
        echo "Updating system with Pacman"
        paru -Syu

    elif grep -qi "Gentoo" /etc/os-release; then
        echo "Updating system with Portage"
        sudo emerge --sync
        sudo emerge -vuDU @world
        sudo emerge --depclean

    elif grep -qi "Debian" /etc/os-release || grep -qi "Ubuntu" /etc/os-release; then
        echo "Updating system with Apt"
        sudo apt update
        sudo apt upgrade

    elif grep -qi "Void" /etc/os-release; then
        echo "Updating system with XBPS"
        sudo xbps-install -Su

    elif grep -qi "Alpine" /etc/os-release; then
        echo "Updating system with APK"
        sudo apk --update-cache upgrade

    elif grep -qi "NixOS" /etc/os-release; then
        echo "Updating system with Nix"
        sudo nix-channel --update
        sudo nixos-rebuild switch

    elif grep -qi "Kinoite" /etc/os-release || grep -qi "Silverblue" /etc/os-release; then
        echo "Updating system with rpm-ostree"
        sudo rpm-ostree upgrade

    elif grep -qi "MicroOS" /etc/os-release; then
        echo "Updating system with transactional-update"
        sudo transactional-update pkg dist-upgrade

        echo "Updating toolbox containers"
        for toolbox in $(toolbox list | grep -v "CONTAINER ID" | tr -s ' ' | cut -d ' ' -f 11); do
            toolbox run --container $toolbox sudo zypper dup
        done

    elif grep -qi "Fedora" /etc/os-release || \
        grep -qi "Alma" /etc/os-release || \
        grep -qi "Red" /etc/os-release || \
        grep -qi "Oracle" /etc/os-release || \
        grep -qi "Rocky" /etc/os-release; then

        if command -v dnf &> /dev/null; then
            echo "Updating system with DNF"
            sudo dnf upgrade
        else
            echo "Updating system with YUM"
            sudo yum upgrade
        fi

    elif grep -qi "SUSE" /etc/os-release; then
        echo "Updating system with Zypper"
        sudo zypper dup

    elif grep -qi "FreeBSD" /etc/os-release; then
        echo "Updating system with FreeBSD Update and Pkg"
        sudo freebsd-update fetch install
        sudo pkg upgrade

    elif grep -qi "OpenBSD" /etc/os-release; then
        echo "Updating system with pkg_add"
        sudo pkg_add -u

    elif grep -qi "lfs" /etc/os-release; then
        echo "lol"

    else
        echo "System upgrade is not supported on this distribution."
    fi

    if command -v flatpak &> /dev/null; then
        echo "Updating flatpaks"
        flatpak update
    fi

    if command -v snap &> /dev/null; then
        echo "Updating snaps"
        sudo snap refresh
    fi

    if command -v rustup &> /dev/null; then
        echo "Updating Rust"
        rustup update
    fi

    if command -v nix-channel &> /dev/null; then
        echo "Updating Nix"
        nix-channel --update
    fi
}

pfetch
