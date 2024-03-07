Set-Location $env:TEMP
git clone https://github.com/mrivnak/CascadiaMono-Nerd-Font

$ShellObject = New-Object -ComObject shell.application
$Fonts = $ShellObject.NameSpace(0x14)
$FontsToInstall = Get-ChildItem CascadiaMono-Nerd-Font -Recurse -Include '*.ttf','*.ttc','*.otf'
ForEach ($F in $FontsToInstall){
    $FullPath = $F.FullName
    $Name = $F.Name
    $UserInstalledFonts = "$ENV:USERPROFILE\AppData\Local\Microsoft\Windows\Fonts"
    If (!(Test-Path "$UserInstalledFonts\$Name")){
        $Fonts.CopyHere($FullPath)
    }
}
