$ScriptPath = $MyInvocation.MyCommand.Path
$DotfilesPath = Split-Path $(Split-Path $ScriptPath -Parent) -Parent

# Install files
# Starship
New-Item -Type Directory -Force $HOME\.config | Out-Null
Copy-Item -Force $DotfilesPath\.config\starship.toml $HOME\.config\
Copy-Item -Recurse -Force $DotfilesPath\.config\micro $HOME\.config\

New-Item -Type Directory -Force $(Split-Path $PROFILE -Parent) | Out-Null
Copy-Item -Force $DotfilesPath\Microsoft.PowerShell_profile.ps1 $PROFILE
