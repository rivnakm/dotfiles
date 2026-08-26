# User environment setup
$env.SHELL = "nu"

# Integrations
mkdir ~/.cache
zoxide init nushell | save -f ~/.cache/zoxide.nu

# Python virtual environments add an addition component to the prompt, starship already does this for us
$env.VIRTUAL_ENV_DISABLE_PROMPT = true
