$ScriptPath = $MyInvocation.MyCommand.Path
$DotfilesPath = Split-Path $(Split-Path $ScriptPath -Parent) -Parent

# Install files
# Starship
New-Item -Type Directory -Force $HOME\.config | Out-Null
Copy-Item -Force $DotfilesPath\.config\starship.toml $HOME\.config\starship.toml

# Neovim
if (Test-Path -Path $HOME\AppData\Local\nvim) {
	Write-Output "neovim config folder exists, skipping..."
} else {
	git clone https://github.com/mrivnak/neovim-config $HOME\AppData\Local\nvim
}

New-Item -Type Directory -Force $(Split-Path $PROFILE -Parent) | Out-Null
Copy-Item -Force $DotfilesPath\Microsoft.PowerShell_profile.ps1 $PROFILE
