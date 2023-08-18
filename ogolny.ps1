# irm https://raw.githubusercontent.com/bogdaba/scrip/main/ogolny.ps1 | iex

# Define array of commands
$commands = @(
    @{Cmd = "wuauclt /detectnow /updatenow"; Desc = "Windows Update"},
    @{Cmd = "sfc /scannow"; Desc = "System File Check"},
    @{Cmd = "DISM /Online /Cleanup-Image /CheckHealth"; Desc = "DISM CheckHealth"},
    @{Cmd = "DISM /Online /Cleanup-Image /ScanHealth"; Desc = "DISM ScanHealth"},
    @{Cmd = "DISM /Online /Cleanup-Image /RestoreHealth"; Desc = "DISM RestoreHealth"},
    #@{Cmd = "chkdsk c: /f /r"; Desc = "Check Disk C:"},
    #@{Cmd = "chkdsk d: /f /r"; Desc = "Check Disk D:"},
    @{Cmd = "ipconfig /flushdns"; Desc = "Flush DNS"},
    @{Cmd = "ipconfig /registerdns"; Desc = "Register DNS"},
    @{Cmd = "ipconfig /release"; Desc = "IP Release"},
    @{Cmd = "ipconfig /renew"; Desc = "IP Renew"},
    @{Cmd = "gpupdate /force"; Desc = "Force Group Policy Update"}
)

# Loop through each command
foreach ($command in $commands) {
    Write-Host "Starting $($command.Desc)..."
    try {
        # Execute the command
        Invoke-Expression $command.Cmd | Out-Host
        Write-Host "$($command.Desc) completed successfully."
    } catch {
        Write-Host "An error occurred during $($command.Desc)."
        Write-Host $_.Exception.Message
    }
    Write-Host ""
}

# Ran following commands on user's PC: "wuauclt /detectnow /updatenow", "sfc /scannow", "DISM /Online /Cleanup-Image /CheckHealth", "DISM /Online /Cleanup-Image /ScanHealth", "DISM /Online /Cleanup-Image /RestoreHealth" "ipconfig /flushdns", "ipconfig /registerdns", "ipconfig /release", "ipconfig /renew", "gpupdate /force"