#!/bin/bash

cd $HOME

# Download and install dotfiles
git clone https://github.com/mrivnak/dotfiles
cp dotfiles/.zshrc .
cp dotfiles/.vimrc .
cp dotfiles/cat .

# Install Oh My Zsh
CHSH='no' RUNZSH='no' KEEP_ZSHRC='yes' sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install themes and plugins
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Change default shell
if [ $SHELL != $(which zsh) ]
then
    sudo usermod -s $(which zsh) $USER
fi

zsh