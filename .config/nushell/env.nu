# Nushell Environment Config File

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# Prompt setup
# Starship handles most things, but it doesn't have vi-mode integration with nu yet
$env.PROMPT_INDICATOR_VI_NORMAL = "| "
$env.PROMPT_INDICATOR_VI_INSERT = ": "

# User environment setup
$env.SHELL = "nu"
$env.LANG = "en_US.UTF-8"
$env.TZ = "America/New_York"
$env.EDITOR = "nvim"
$env.TOOLBOX_SHELL = (which nu)

# PATH Configuration
use std "path add"
path add ($env.HOME | path join ".local" "bin")

# Cargo Configuration
$env.CARGO_HOME = ($env.HOME | path join ".cargo")
path add ($env.CARGO_HOME | path join "bin")

# C/C++ Configuration
$env.CC = "clang"
$env.CXX = "clang++"
$env.CMAKE_GENERATOR = "Ninja"

# vcpkg Configuration
$env.VCPKG_ROOT = ($env.HOME | path join ".local" "share" "vcpkg")
path add ($env.VCPKG_ROOT)

# .NET Configuration
$env.DOTNET_HOME = ($env.HOME | path join ".dotnet")
path add ($env.DOTNET_HOME | path join "tools")
$env.DOTNET_NOLOGO = true

# Generate starship env file
starship init nu | save -f "~/.cache/starship/init.nu"

# Generate opam env file
# opam doesn't support nu so this is a wonky adapter I wrote
mkdir ~/.cache/opam
python ~/.local/share/opam_env_nushell_adapter/main.py | save -f "~/.cache/opam/init.nu"
