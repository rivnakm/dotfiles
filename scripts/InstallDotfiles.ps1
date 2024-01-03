$ScriptPath = $MyInvocation.MyCommand.Path
$DotfilesPath = Split-Path $(Split-Path $ScriptPath -Parent) -Parent

# Install files
# Neovim
if (Test-Path -Path $HOME\AppData\Local\nvim) {
	Push-Location $HOME\AppData\Local\nvim
	git pull
	Pop-Location
} else {
	git clone https://github.com/mrivnak/neovim-config $HOME\AppData\Local\nvim
}

# Starship
New-Item -Type Directory -Force $HOME\.config | Out-Null
Copy-Item -Force $DotfilesPath\.config\starship.toml $HOME\.config\
Copy-Item -Recurse -Force $DotfilesPath\.config\micro $HOME\.config\

New-Item -Type Directory -Force $(Split-Path $PROFILE -Parent) | Out-Null
Copy-Item -Force $DotfilesPath\Microsoft.PowerShell_profile.ps1 $PROFILE
