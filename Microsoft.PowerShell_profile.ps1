# Import-Module posh-git
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# Set-PSReadLineKeyHandler -Key RightArrow -Function AcceptSuggestion

Set-Alias -Name sudo -Value gsudo

function Git-Status { git status }
Set-Alias -Name gs -Value Git-Status

function Git-Push { git push }
Set-Alias -Name gpu -Value Git-Push

function Git-Pull { git pull }
Set-Alias -Name gpl -Value Git-Pull

function Git-Add { git add @args }
Set-Alias -Name ga -Value Git-Add

function Git-Commit ([string]$Message) { git commit -m $Message }
Set-Alias -Force -Name gc -Value Git-Commit

Invoke-Expression (&starship init powershell)
