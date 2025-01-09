Set-PSReadLineOption -Colors @{
    Operator = "`e[97m"
    Parameter = "`e[97m"
    InlinePrediction = "`e[97m"
}

Invoke-Expression (&starship init powershell)
