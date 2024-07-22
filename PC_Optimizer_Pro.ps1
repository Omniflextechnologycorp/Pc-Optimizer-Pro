# PC Optimizer Pro

# Ensure the script runs with administrative privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as an Administrator."
    exit
}

# Define helper functions
function Uninstall-Bloatware {
    Write-Host "Uninstalling bloatware..."
    # Example: Uninstall Xbox app and other bloatware
    Get-AppxPackage *xbox* | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxPackage *bing* | Remove-AppxPackage -ErrorAction SilentlyContinue
}

function Disk-Cleanup {
    Write-Host "Running Disk Cleanup..."
    Start-Process cleanmgr -ArgumentList "/sagerun:1" -NoNewWindow -Wait
}

function Defragment-Drive {
    Write-Host "Defragmenting drive..."
    defrag C: /O
}

function Disable-Startup-Programs {
    Write-Host "Disabling unnecessary startup programs..."
    Get-CimInstance Win32_StartupCommand | Where-Object { $_.User -ne "Administrator" -and $_.Location -notlike "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" } | Remove-CimInstance
}

function Update-Software {
    Write-Host "Updating software..."
    # Check and install Windows updates
    Install-Module PSWindowsUpdate -Force -SkipPublisherCheck
    Import-Module PSWindowsUpdate
    Get-WindowsUpdate -AcceptAll -Install -AutoReboot
}

function Check-Malware {
    Write-Host "Checking for malware..."
    Start-MpScan -ScanType QuickScan
}

function Delete-Unnecessary-Files {
    Write-Host "Deleting unnecessary files..."
    Get-ChildItem "C:\Windows\Temp" -Recurse | Remove-Item -Force -ErrorAction SilentlyContinue
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
}

function Optimize-Web-Browser {
    Write-Host "Optimizing web browser..."
    # Example: Clear Internet Explorer cache
    RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
}

function Configure-GPU {
    Write-Host "Configuring GPU settings..."
    # Add specific commands for your GPU software here (e.g., Nvidia, AMD)
    Write-Host "Skipping GPU configuration. Customize this section as needed."
}

function Check-Viruses-Spyware {
    Write-Host "Checking for viruses and spyware..."
    Start-MpScan -ScanType FullScan
}

# Main script execution
Uninstall-Bloatware
Disk-Cleanup
Defragment-Drive
Disable-Startup-Programs
Update-Software
Check-Malware
Delete-Unnecessary-Files
Optimize-Web-Browser
Configure-GPU
Check-Viruses-Spyware

# Display message and restart
Write-Host "Add more RAM to your computer if possible."
Restart-Computer -Force