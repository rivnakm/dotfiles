#!/usr/bin/env bash

for fetch in neofetch pfetch
do
    git clone https://github.com/dylanaraps/$fetch.git
    pushd $fetch
    sudo make install
    popd
    rm -rf $fetch
done