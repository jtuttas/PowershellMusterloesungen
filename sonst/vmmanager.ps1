<#
.Synopsis
   Löscht alle Snapshorts und erstellt einen Snapshot "base" 
.DESCRIPTION
   Löscht alle Snapshorts und erstellt einen Snapshot "base" 
.EXAMPLE
   init-block -vmname "linux"

#>
function init-block
{
    Param
    (
        # Name der Virtuellen Maschine
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $vmname

    )

    Begin
    {
        try {
        Write-Host "Löschen Snapshots für $vmname"
        Remove-VMSnapshot -VMName $vmname -ErrorAction Stop -ErrorVariable $e
        Write-Host "Erstelle base Snapshot"
        Checkpoint-VM -Name $vmname -SnapshotName 'base' -ErrorAction Stop
        }
        catch {
            Write-Host "Fehler beim initialisieren des VM $vmname : $_" -BackgroundColor red
        }
    }
    Process
    {
    }
    End
    {
    }
}

<#
.Synopsis
   Erstellt einen Snapshot unter base mit dem namen block
.DESCRIPTION
   Erstellt einen Snapshot unter base mit dem namen block
.EXAMPLE
   create-block -vmname "linux" -block "rot"

#>
function create-block
{
    Param
    (
        # Name der Virtuellen Maschine
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $vmname,
        # Name des Blocks
        [Parameter(Mandatory=$true)]
        $block

    )

    Begin
    {
        try {
            Write-Host "aktiviere Snapshot 'base' für $vmname"
            Restore-VMSnapshot -VMName $vmname -Name 'base' –confirm:$False -ErrorAction Stop
            Write-Host "Erstelle Snapshot $block"
            Checkpoint-VM -Name $vmname -SnapshotName $block -ErrorAction Stop
         }
         catch {         
            Write-Host "Fehler beim Erzeugen des Block $block für die VM $vmname : $_" -BackgroundColor red
         }
    }
    Process
    {
    }
    End
    {
    }
}

<#
.Synopsis
   Schaltet zwischen zwei Snapshots um
.DESCRIPTION
   Schaltet zwischen zwei Snapshots um
.EXAMPLE
    Schaltet die VM "linux" zwischen den Blöcken "rot" und "gelb" um!
   switch-block -vmname "linux" -fromblock "rot" -toblock "gelb"

#>
function switch-block
{
    Param
    (
        # Name der Virtuellen Maschine
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $vmname,
        # Name des from Blocks
        [Parameter(Mandatory=$true)]
        $fromblock,
        # Name des from Blocks
        [Parameter(Mandatory=$true)]
        $toblock
    )

    Begin
    {
        try {
            $sn = Get-VMSnapshot -VMName $vmname -Name $fromblock -ErrorAction Stop             
            Write-Host "Lösche Snapshot '$fromblock' für $vmname (Merge)"
            Remove-VMSnapshot -VMName $vmname -Name $fromblock -ErrorAction Stop
            Write-Host "Erstelle Snapshot '$fromblock' für $vmname (Merge)"
            Checkpoint-VM -Name $vmname -SnapshotName $fromblock  -ErrorAction Stop
            Write-Host "Aktiviere Snapshot $toblock für $vmname"
            Restore-VMSnapshot -VMName $vmname -Name $toblock –confirm:$False -ErrorAction Stop
            }
            catch {                
                Write-Host "Fehler beim Switchen des Blockes von $fromblock nach $toblock für die VM $vmname : $_" -BackgroundColor red
            }
    }
    Process
    {
    }
    End
    {
       
    }
}