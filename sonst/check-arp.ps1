<#
.Synopsis
   CMD-let was den arp cache überwacht
.DESCRIPTION
   CMD-let was den arp cache überwacht
.EXAMPLE
   check-arp 172.31.0.254 a0-36-9f-51-a9-98
#>
function check-arp
{
    Param
    (
        # IP Adresse des GateWays
        [Parameter(Mandatory=$true,
                   Position=0)]
        $ipAdress,

        # MAC Adresse des Gateways
        [Parameter(Mandatory=$true,
                   Position=1)]
        $macAdress,

        # Eigene IP Adresse des Interfaces
        [Parameter(Position=2)]
        $ownIp

    )

    while ($true) {
        if ($ownIp.lenfth -ne 0) {
            $arp= arp -a $ipAdress -N $ownIp  
        }
        else {
            $arp= arp -a $ipAdress  
        }
        
        $s=$arp.split(" ")
        $ip=$null
        $mac=$null
        foreach ($element in $s) {
            if ($element.indexof(".") -ne -1) {
                $ip=$element
            }
            if ($element.indexof("-") -ne -1) {
                $mac=$element
            }
        }
        if ($mac -ne $macAdress) {
            $evilIp = arp -a | select-string $mac |% { $_.ToString().Trim().Split(" ")[0] }            
            Write-Host "Achtung Angriff von MAC "$mac" mit ip "($evilIp[1]) -BackgroundColor Red -ForegroundColor White
        }
        else {
            Write-Host "Alles OK" -BackgroundColor Green -ForegroundColor White
        }
        sleep 1
    }
 
}
