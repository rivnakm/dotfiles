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

# C/C++ Configuration
$env.CC = "clang"
$env.CXX = "clang++"
$env.CMAKE_GENERATOR = "Ninja"

# Generate starship env file
starship init nu | save -f "~/.cache/starship/init.nu"
