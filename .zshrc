# Color Definitions
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7
BRIGHT_BLACK=8
BRIGHT_RED=9
BRIGHT_GREEN=10
BRIGHT_YELLOW=11
BRIGHT_BLUE=12
BRIGHT_MAGENTA=13
BRIGHT_CYAN=14
BRIGHT_WHITE=15

# WSL
if [[ $PWD == "/mnt/c/Users/Michael" ]]
then
	cd $HOME
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="yyyy-mm-dd"

plugins=(
	alias-finder
	archlinux
	brew
	cargo
	command-not-found
	common-aliases
	cp
	debian
	dnf
	docker
	docker-compose
	docker-machine
	dotnet
	extract
	git
	gitignore
	golang
	pip
	python
	rust
	rustup
	sudo
	suse
	systemd
	osx
	ubuntu
	virtualenv
	yarn
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR=vim

# CMake
export CMAKE_GENERATOR='Unix Makefiles'

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Visual Studio Code
alias sudo-code='sudo code --user-data-dir="~/.vscode-root"'

# Set personal aliases
## ls
alias ls="lsd"
alias l="ls -lah"
alias la="ls -a"
alias lt="ls --tree"

alias rf="rm -rf"
alias nf="neofetch"
alias pf="pfetch"
alias sudo="sudo "  # Makes sudo use your custom aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# find distro color
if head -n 1 /etc/os-release | grep -q -i Arch 
then
	COLOR=$CYAN
elif head -n 1 /etc/os-release | grep -q -i Artix 
then
	COLOR=$CYAN
elif head -n 1 /etc/os-release | grep -q -i CentOS 
then
	COLOR=$BLUE
elif head -n 1 /etc/os-release | grep -q -i Debian 
then
	COLOR=$RED
elif head -n 1 /etc/os-release | grep -q -i Fedora 
then
	COLOR=$BLUE
elif head -n 1 /etc/os-release | grep -q -i Gentoo 
then
	COLOR=$MAGENTA
elif head -n 1 /etc/os-release | grep -q -i Manjaro 
then
	COLOR=$GREEN
elif head -n 1 /etc/os-release | grep -q -i NixOS 
then
	COLOR=$BLUE
elif head -n 1 /etc/os-release | grep -q -i openSUSE 
then
	COLOR=$GREEN
elif head -n 1 /etc/os-release | grep -q -i Pop 
then
	COLOR=$CYAN 
elif head -n 1 /etc/os-release | grep -q -i Rocky 
then
	COLOR=$GREEN
elif head -n 1 /etc/os-release | grep -q -i Ubuntu 
then
	COLOR=$YELLOW
elif head -n 1 /etc/os-release | grep -q -i Void 
then
	COLOR=$GREEN
fi

export PF_INFO='ascii title os kernel pkgs uptime shell editor memory palette'

# pfetch text color
export PF_COL2=8

# pfetch title and label color
export PF_COL1=$COLOR
export PF_COL3=$COLOR

# Run pfetch
pfetch
