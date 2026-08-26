# General nu config
$env.config.show_banner = false
$env.config.color_config.hints = "white_dimmed"
$env.config.buffer_editor = "nvim"

# History
$env.config.history.max_size = 100_000
$env.config.history.sync_on_enter = true
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = false

# Aliases
alias l = ls
alias chm = chezmoi

# Integrations, etc.
mkdir ($nu.data-dir | path join "vendor/autoload")

# Starship
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Zoxide
source ~/.cache/zoxide.nu

fastfetch
