#!/bin/bash

mkdir -pv .local/share/fonts/
pushd /tmp
git clone --depth=1 https://github.com/ryanoasis/nerd-fonts
./nerd-fonts/install.sh FiraCode
popd