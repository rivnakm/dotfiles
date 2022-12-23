$ScriptPath = $MyInvocation.MyCommand.Path
$DotfilesPath = Split-Path $(Split-Path $ScriptPath -Parent) -Parent

# Install files
# Starship
New-Item -Type Directory $HOME\.config
Copy-Item $DotfilesPath\.config\starship.toml $HOME\.config\starship.toml

# Neovim
git clone https://github.com/mrivnak/neovim-config $HOME\AppData\Local\nvim

Copy-Item $DotfilesPath\Microsoft.PowerShell_profile.ps1 $PROFILE
