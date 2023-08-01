# irm https://raw.githubusercontent.com/bogdaba/scrip/main/nhc.ps1 | iex

# Getting user input for URL
$url = Read-Host "Please enter URL to collect stats for"

# Getting local username
$username = [Environment]::UserName

# Setting up output file on the Desktop
$outputFile = "$([Environment]::GetFolderPath("Desktop"))\nhc.txt"

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
Write-Output "Writing user information to file..."
Write-ToFile "***********************"
Write-ToFile "Username=$username"
Write-ToFile "***********************"

# Running commands and capturing output
Write-Output "Collecting IP configuration..."
Write-ToFile (ipconfig /all)
Write-ToFile "***********************"

Write-Output "Collecting network routing tables..."
Write-ToFile (netstat -rn)
Write-ToFile "***********************"

Write-Output "Collecting workstation statistics..."
Write-ToFile "Uptime and Statistics"
Write-ToFile (net statistics workstation)
Write-ToFile "***********************"

Write-Output "Pinging specified URL..."
Start-Job -ScriptBlock {param($url) ping -w 1 -n 5 $url} -ArgumentList $url | Wait-Job -Timeout 10 | Receive-Job
Write-ToFile "***********************"

Write-Output "Pinging 'whatismyip.com'..."
Start-Job -ScriptBlock {ping -w 1 -n 5 'whatismyip.com'} | Wait-Job -Timeout 10 | Receive-Job
Write-ToFile "***********************"

Write-Output "Pinging 'www.google.com'..."
Start-Job -ScriptBlock {ping -w 1 -n 5 'www.google.com'} | Wait-Job -Timeout 10 | Receive-Job
Write-ToFile "***********************"

Write-Output "Tracing route to specified URL..."
Start-Job -ScriptBlock {param($url) tracert -w 1 $url} -ArgumentList $url | Wait-Job -Timeout 60 | Receive-Job
Write-ToFile "***********************"

Write-Output "Collecting PAC file information..."
Write-ToFile "PAC File"
Write-ToFile ((Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name AutoConfigURL).AutoConfigURL)
Write-ToFile "***********************"

Write-Output "Collecting Proxy settings..."
Write-ToFile "Proxy Settings"
$proxySettings = netsh winhttp show proxy
Write-ToFile $proxySettings


Write-Output "Collecting system hotfix information..."
Write-ToFile (Get-HotFix)

Write-Output "Congrats! Your script executed successfully."
