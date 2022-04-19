#!/bin/bash

for fetch in neofetch pfetch
do
    git clone https://github.com/dylanaraps/$fetch.git
    pushd $fetch
    sudo make Install
    popd
    rm -rf $fetch
done