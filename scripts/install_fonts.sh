#!/usr/bin/env bash

pushd /tmp
#wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip -O firacode.zip
#sudo mkdir -pv "/usr/share/fonts/Fira Code"
#sudo unzip firacode.zip -d "/usr/share/fonts/Fira Code"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip -O hack.zip
sudo mkdir -pv "/usr/share/fonts/Hack"
sudo unzip hack.zip -d "/usr/share/fonts/Hack"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip -O UbuntuMono.zip
sudo mkdir -pv "/usr/share/fonts/UbuntuMono"
sudo unzip UbuntuMono.zip -d "/usr/share/fonts/UbuntuMono"
popd
cp -rv dotfiles/.local/share/fonts $HOME/.local/share/