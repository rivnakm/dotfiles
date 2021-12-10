#!/bin/bash
set -e

confirm () {
    read -r -p "$@ [Y/n] " answer
    if [[ $answer =~ ^([yY][eE][sS]|[yY]|"")$ ]]
    then
        echo "true"
    else
        echo "false"
    fi
}

cd $HOME

# Download and install dotfiles
if [ -d "$HOME/dotfiles" ]
then
    rm -rfv dotfiles
fi 

git clone https://github.com/mrivnak/dotfiles
mkdir -pv .config/nvim
cp -v dotfiles/.zshrc .
cp -v dotfiles/.p10k.zsh .
cp -v dotfiles/init.vim .config/nvim/
cp -v dotfiles/cat .

# Install Oh My Zsh
if [ -d "$HOME/.oh-my-zsh" ]
then
    rm -rfv .oh-my-zsh
fi 
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
result=$(confirm "Do you want to install fonts?")
if [[ $result == "true" ]]
then
    mkdir -pv .local/share/fonts/
    pushd /tmp
    git clone --depth=1 https://github.com/ryanoasis/nerd-fonts
    ./nerd-fonts/install.sh FiraCode
    popd
fi

# Install git versions of neofetch and pfetch
result=$(confirm "Do you want to install neofetch and pfetch?")
if [[ $result == "true" ]]
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

# Install wallpapers
result=$(confirm "Do you want to install wallpapers?")
if [[ $result == "true" ]]
then
    mkdir -pv $HOME/Pictures
    git clone https://github.com/mrivnak/os-wallpapers $HOME/Pictures/os-wallpapers
fi

zsh