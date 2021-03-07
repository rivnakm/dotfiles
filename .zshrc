# WSL
if [[ $PWD == "/mnt/c/Users/Michael" ]]
then
	cd $HOME
fi
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
export LIBGL_ALWAYS_INDIRECT=true

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin

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
	dotnet
	extract
	git
	gitignore
	pip
	python
	rust
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

# CMake
export CMAKE_GENERATOR='Unix Makefiles'

# You may need to manually set your language environment
export LANG=en_US.UTF-8


# Visual Studio Code
export EDITOR=code
alias sudo-code='sudo code --user-data-dir="~/.vscode-root"'
alias sudo-code-insiders='sudo code-insiders --user-data-dir="~/.vscode-root"'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases
alias l="ls -lah"

alias lock="xscreensave-command -lock"
alias suspend="systemctl suspend"
alias hibernate="systemctl hibernate"
alias logout="bspc quit"
alias reboot="systemctl reboot"
alias shutdown="systemctl poweroff"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PF_INFO='ascii title os kernel pkgs uptime shell editor memory palette'

# pfetch text color
export PF_COL2=8

# pfetch title and ascii color
export PF_COL1=6
export PF_COL3=6

# Run pfetch
pfetch
