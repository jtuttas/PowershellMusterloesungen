function Write-SmartState {
    param (
        [Parameter(Mandatory=$true)]
        [String] $file
    )

    $w=(Get-WMIObject Win32_DiskDrive | Select-Object Status,Model,Date | ForEach-Object {$_.Date=(get-Date);$_}) | Export-Csv -NoTypeInformation -Path $file -Append
    
}