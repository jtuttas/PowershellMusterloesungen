<#
.Synopsis
   Löscht alle Snapshorts und erstellt einen Snapshot "base" 
.DESCRIPTION
   Löscht alle Snapshorts und erstellt einen Snapshot "base" 
.EXAMPLE
   init-block -vmname "linux"
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
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
            Remove-VMSnapshot -VMName $vmname 
            Write-Host "Löschen Snapshots für $vmname"
    }
    Process
    {
    }
    End
    {
        Write-Host "Erstelle base Snapshot"
        Checkpoint-VM -Name $vmname -SnapshotName 'base'
    }
}

<#
.Synopsis
   erstellt einen Snapshot unter base
.DESCRIPTION
   erstellt einen Snapshot unter base
.EXAMPLE
   create-block -vmname "linux" -blockname
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
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
            Restore-VMSnapshot -VMName $vmname -Name 'base' –confirm:$False
            Write-Host "aktiviere Snapshot 'base' für $vmname"
    }
    Process
    {
    }
    End
    {
        Write-Host "Erstelle Snapshot $block"
        Checkpoint-VM -Name $vmname -SnapshotName $block 
    }
}

<#
.Synopsis
   Schaltet zwischen zwei Snapshots um
.DESCRIPTION
   Schaltet zwischen zwei Snapshots um
.EXAMPLE
   switch-block -vmname "linux" -fromblock "rot" -toblock "gelb"
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
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
            Write-Host "Lösche Snapshot '$fromblock' für $vmname (Merge)"
            Remove-VMSnapshot -VMName $vmname -Name $fromblock
            Write-Host "Erstelle Snapshot '$fromblock' für $vmname (Merge)"
            Checkpoint-VM -Name $vmname -SnapshotName $fromblock 
            
    }
    Process
    {
    }
    End
    {
        Write-Host "Aktiviere Snapshot $toblock für $vmname"
         Restore-VMSnapshot -VMName $vmname -Name $toblock –confirm:$False
    }
}