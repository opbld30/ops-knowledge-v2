Param(
    [Parameter(Mandatory=$true, Position=0,
    ParameterSetName = "PAT", HelpMessage = "A GitHub Personal Access Token")]
    [String]
    $pat
)

$tempDirectoryBase = New-TemporaryFile | %{ rm $_; mkdir $_ }
$repoUrl = "https://anything:${pat}@github.com/OPS-E2E-PPE/azure-docs-pr.git"
$index = 0
while($true)
{
    $index++
    
    # Print Timestamp
    $timestamp = "PS-${$index}:" + (Get-Date -format MM/dd/yy` hh:mm:ss)
    Write-Host -ForegroundColor Magenta $timestamp 

    # Print LogicalDiskFreeSpace
    Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" -ComputerName . | Format-Table DeviceId, MediaType, VolumeName, @{n="Size(GB)";e={[math]::Round($_.Size/1GB,2)}},@{n="FreeSpace(GB)";e={[math]::Round($_.FreeSpace/1GB,2)}}
    
    # Clone repo
    $gitDir = Join-Path $tempDirectoryBase $(New-Guid)
    $command = "git clone $repoUrl $gitDir"
    Write-Host $command
    iex $command

    # Sleep
    Start-Sleep -Seconds 10
}
