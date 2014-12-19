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
        $macAdress
    )

    while ($true) {
        $arp= arp -a 
        $hmac = @{};
        foreach ($line in $arp) {
            $s=$line.split(" ")
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
            if ($ip -ne $null -and $mac -ne $null) {
                $hmac[$ip]=$mac
            }
        }
        if ($hmac[$ipAdress] -ne $macAdress) {
            Write-Host "Achtung Angriff von MAC "$hmac[$ipAdress] -BackgroundColor Red -ForegroundColor White
        }
        else {
            Write-Host "Alles OK" -BackgroundColor Green -ForegroundColor White
        }
        sleep 1
    }
 
}
