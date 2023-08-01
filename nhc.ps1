# irm https://raw.githubusercontent.com/bogdaba/scrip/main/nhc.ps1 | iex

# Getting user input for URL
$url = Read-Host "Please enter URL to collect stats for"

# Getting local username
$username = [Environment]::UserName

# Setting up output file
$outputFile = "$env:APPDATA\NHC\NHC.rtf"

# Creating output directory if it does not exist
if (!(Test-Path -Path "$env:APPDATA\NHC")) {
    New-Item -ItemType Directory -Path "$env:APPDATA\NHC"
}

# Initializing the output file
if (Test-Path -Path $outputFile) {
    Remove-Item -Path $outputFile
}

# Helper function to write to file
function Write-ToFile {
    param (
        $content
    )
    Add-Content -Path $outputFile -Value $content
}

# Write info to file
Write-ToFile "***********************"
Write-ToFile "Username=$username"
Write-ToFile "***********************"

# Running commands and capturing output
Write-ToFile (ipconfig /all)
Write-ToFile "***********************"
Write-ToFile (netstat -rn)
Write-ToFile "***********************"
Write-ToFile "Uptime and Statistics"
Write-ToFile (net statistics workstation)
Write-ToFile "***********************"
Write-ToFile (ping -w 1 -n 5 $url)
Write-ToFile "***********************"
Write-ToFile (ping -w 1 -n 5 'whatismyip.com')
Write-ToFile "***********************"
Write-ToFile (ping -w 1 -n 5 'www.google.com')
Write-ToFile "***********************"
Write-ToFile (tracert -w 1 $url)
Write-ToFile "***********************"
Write-ToFile "PAC File"
Write-ToFile ((Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name AutoConfigURL).AutoConfigURL)
Write-ToFile "***********************"
Write-ToFile "Proxy Settings"
Write-ToFile ((Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer).ProxyServer)
Write-ToFile "***********************"
Write-ToFile (Get-HotFix)

Write-Output "Congrats! Your script executed successfully."
