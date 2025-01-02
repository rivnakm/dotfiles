export PATH=$HOME/.cargo/bin:$PATH:$HOME/.local/bin:$HOME/go/bin:$HOME/.dotnet/tools
export LANG=en_US.UTF-8
export TZ=America/New_York
export EDITOR=nvim
export TOOLBOX_SHELL=$(which zsh)

# Use clang as default C/C++ compiler
export CC=clang
export CXX=clang++
export CMAKE_GENERATOR=Ninja

# vcpkg configuration
export VCPKG_ROOT=$HOME/.local/share/vcpkg
export PATH=$PATH:$VCPKG_ROOT

# dotnet CLI configuration
export DOTNET_NOLOGO=true

# opam configuration
[[ ! -r /home/michael/.opam/opam-init/init.zsh ]] || source /home/michael/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null



# Added by Toolbox App
export PATH="$PATH:/home/michael/.local/share/JetBrains/Toolbox/scripts"

