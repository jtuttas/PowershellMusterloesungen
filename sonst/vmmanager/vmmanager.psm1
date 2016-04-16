<#
.Synopsis
   Löscht alle Snapshorts und erstellt einen Snapshot "base" 
.DESCRIPTION
   Löscht alle Snapshorts und erstellt einen Snapshot "base" 
.EXAMPLE
   Init Block for the named VM
   init-block -vmname "linux"
.EXAMPLE
   Init Block for a List of VM's
   Import-Csv C:\Users\jtutt_000\Temp\test.csv | init-block 
#>
function init-block
{
    Param
    (
        # Name der Virtuellen Maschine
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromPipeline=$true,
                   Position=0)]
        [Alias('VM')]
        $vmname

    )

    Begin
    {
       
    }
    Process
    {
       
             try {
                Write-Host "Löschen Snapshots für "$vmname.VM 
                Remove-VMSnapshot -VMName $vmname.VM -ErrorAction Stop -ErrorVariable $e
                Write-Host "Erstelle base Snapshot"
                Checkpoint-VM -Name $vmname.VM -SnapshotName 'base' -ErrorAction Stop
            }
            catch {
                Write-Host "Fehler beim initialisieren des VM $vmname : $_" -BackgroundColor red
            }
      
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
.EXAMPLE
   Create Block for a List of VM's
   Import-Csv C:\Users\jtutt_000\Temp\test.csv | create-block -block "rot"

#>
function create-block
{
    Param
    (
        # Name der Virtuellen Maschine
        [Parameter(Mandatory=$true,
                    ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [Alias('VM')]
        $vmname,
        # Name des Blocks
        [Parameter(Mandatory=$true)]
        $block

    )

    Begin
    {
    }
    Process
    {
       
            try {
                $sn = Get-VMSnapshot -VMName $vmname.VM -Name $block -ErrorAction SilentlyContinue
                if ($sn) {
                    Write-Host "Fehler beim Erzeugen des Block $block für die VM"$vmname.VM": Der Block existiert schon!" -BackgroundColor red
                }
                else {
                    Write-Host "aktiviere Snapshot 'base' für "$vmname.VM
                    Restore-VMSnapshot -VMName $vmname.VM -Name 'base' –confirm:$False -ErrorAction Stop
                    Write-Host "Erstelle Snapshot $block"
                    Checkpoint-VM -Name $vmname.VM -SnapshotName $block -ErrorAction Stop
                }
             }
             catch {         
                Write-Host "Fehler beim Erzeugen des Block $block für die VM $vmname : $_" -BackgroundColor red
             }
       
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
.EXAMPLE
   Switch Blocks for a List of VM's
   Import-Csv C:\Users\jtutt_000\Temp\test.csv | switch-block -fromblock "rot" -toblock "gelb"

#>
function switch-block
{
    Param
    (
        # Name der Virtuellen Maschine
        [Parameter(Mandatory=$true,
                    ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [Alias('VM')]
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
    }
    Process
    {
       
        try {
            $sn = Get-VMSnapshot -VMName $vmname.VM -Name $fromblock -ErrorAction Stop            
            $machine = Get-VM -Name $vmname.VM
            if ($machine.ParentCheckpointName -ne $fromblock) {
                Write-Host "$fromblock is not the current block! Current block is"$machine.ParentCheckpointName -BackgroundColor Red
            }
            else {
                Write-Host "Lösche Snapshot '$fromblock' (Merge) für "$vmname.VM
                Remove-VMSnapshot -VMName $vmname.VM -Name $fromblock -ErrorAction Stop
                Write-Host "Erstelle Snapshot (Merge) '$fromblock' für "$vmname.VM
                Checkpoint-VM -Name $vmname.VM -SnapshotName $fromblock  -ErrorAction Stop 
                Write-Host "Aktiviere Snapshot $toblock für "$vmname.VM
                Restore-VMSnapshot -VMName $vmname.VM -Name $toblock –confirm:$False -ErrorAction Stop
            }
            }
        catch {                
            Write-Host "Fehler beim Switchen des Blockes von $fromblock nach $toblock für die VM "$vmname.VM": $_" -BackgroundColor red
        }            
                   
    }
    End
    {
       
    }
}

Export-ModuleMember -Function init-block
Export-ModuleMember -Function create-block
Export-ModuleMember -Function switch-block