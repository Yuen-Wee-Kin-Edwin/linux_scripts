# RestoreStartMenu.ps1
# Re-registers ShellExperienceHost to restore Start menu and Shutdown button

Write-Output "Re-registering ShellExperienceHost..."
Get-AppxPackage Microsoft.Windows.ShellExperienceHost | ForEach-Object {
    Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"
}

Write-Output "Restarting Windows Explorer..."
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Output "Done! Start menu and Shutdown button should be restored."