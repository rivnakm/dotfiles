#!/bin/bash

get_package_manager() {
    if [ $(head -n 1 /etc/os-release | grep -q -i Arch) ] || [ $(head -n 1 /etc/os-release | grep -q -i Artix) ] || [ $(head -n 1 /etc/os-release | grep -q -i Manjaro) ]
    then
        return "pacman"
    elif [ $(head -n 1 /etc/os-release | grep -q -i CentOS) ] || [ $(head -n 1 /etc/os-release | grep -q -i Fedora) ] || [ $(head -n 1 /etc/os-release | grep -q -i Rocky) ]
    then
        return "dnf"
    elif [ $(head -n 1 /etc/os-release | grep -q -i Debian) ] || [ $(head -n 1 /etc/os-release | grep -q -i Ubuntu) ] || [ $(head -n 1 /etc/os-release | grep -q -i Pop) ]
    then
        return "apt"
    elif head -n 1 /etc/os-release | grep -q -i Gentoo 
    then
        return "portage"
    elif head -n 1 /etc/os-release | grep -q -i openSUSE 
    then
        return "zypper"
    fi
}

cd $HOME

# Download and install dotfiles
git clone https://github.com/mrivnak/dotfiles
cp dotfiles/.zshrc .
cp dotfiles/.p10k.zsh .
cp dotfiles/.vimrc .
cp dotfiles/cat .

# Install Oh My Zsh
CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install themes and plugins
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Change default shell
if [[ $SHELL != $(which zsh) ]]
then
    sudo usermod -s $(which zsh) $USER
fi

# Install fonts
INSTALL_FONTS="${INSTALL_FONTS:=yes}"

if [[ $INSTALL_FONTS == yes ]]
then
    mkdir -pv .fonts/Hack\ Nerd\ Font
    pushd .fonts/Hack\ Nerd\ Font
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
    unzip Hack.zip
    rm Hack.zip
    popd
fi

# Install git versions of neofetch and pfetch
INSTALL_FETCH="${INSTALL_FETCH:=yes}"

if [[ $INSTALL_FETCH == yes ]]
then
    for ITEM in neofetch pfetch
    do
        git clone https://github.com/dylanaraps/$ITEM
        pushd $ITEM
        sudo make install
        popd
        rm -rf $ITEM
    done
fi

# Install git versions of neofetch and pfetch
INSTALL_WALLPAPERS="${INSTALL_WALLPAPERS:=yes}"

if [[ $INSTALL_WALLPAPERS == yes ]]
then
    mkdir -pv $HOME/Pictures
    git clone https://github.com/mrivnak/os-wallpapers $HOME/Pictures/os-wallpapers
fi

# Install LunarVim Dependencies
mkdir -pv $HOME/.config/lvim
case get_package_manager in
    "pacman")
        sudo pacman -Syu --needed npm nodejs python python-pip cargo neovim
        ;;
    "dnf")
        sudo dnf install npm nodejs python3 python3-pip rust-cargo neovim
        ;;
    "apt")
        sudo apt update
        sudo apt install npm nodejs python3 python3-pip cargo neovim
        ;;
    "portage")
        sudo emerge --ask net-libs/nodejs dev-lang/python dev-python/pip dev-lang/rust app-editors/neovim
        ;;
    "zypper")
        sudo zypper refresh
        sudo zypper install npm nodejs python3 python3-pip cargo neovim
        ;;
esac

# Resolve EACCES permissions errors
mkdir -pv $HOME/.npm-global
npm config set prefix '~/.npm-global'

# Install LunarVim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) --yes --overwrite

zsh