# PowerShell Gallery
Install-Module posh-git -Scope CurrentUser -Force
Install-Module PowerShellGet -Force -SkipPublisherCheck

# Update PowerShell Prompt
Import-Module posh-git
Add-PoshGitToProfile -AllHosts