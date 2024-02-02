#!/usr/bin/env bash

# pfetch-rs
echo "Installing pfetch-rs"
cargo install pfetch --locked

# fastfetch
echo "Installing fastfetch"
git clone https://github.com/fastfetch-cli/fastfetch
cd fastfetch
mkdir -p build
cd build
cmake ..
cmake --build . --target fastfetch
sudo cmake --install . --component fastfetch --prefix /usr/local
cd ../..
rm -rf fastfetch
