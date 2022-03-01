#!/bin/bash

pushd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip -O fonts.zip
sudo mkdir -pv "/usr/share/fonts/Fira Code"
sudo unzip fonts.zip -d "/usr/share/fonts/Fira Code"
popd
