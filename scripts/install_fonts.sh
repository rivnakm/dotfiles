#!/bin/bash

pushd /tmp
git clone --depth=1 https://github.com/ryanoasis/nerd-fonts
sudo bash ./nerd-fonts/install.sh --install-to-system-path FiraCode
popd
