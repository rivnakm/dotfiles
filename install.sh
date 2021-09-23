#!/bin/bash

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

zsh