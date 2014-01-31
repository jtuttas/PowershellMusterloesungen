param([String]$ips,[String]$subs) 
$sub=$subs.Split(".")    # Array Oktette der Subnezmaske
$ip=$ips.Split(".")  # Array Oktelle der Netzip
# Netz IP bestimmen
$netz=0,0,0,0
for ($i=0; $i -lt 4;$i++) {
    $netz[$i]=$ip[$i] -band $sub[$i]
}
$imSubnetz=$true
$aktuelleIP=0,0,0,0
[int]$aktuelleIP[0]=$netz[0]
[int]$aktuelleIP[1]=$netz[1]
[int]$aktuelleIP[2]=$netz[2]
[int]$aktuelleIP[3]=$netz[3]
$aktuelleIP[3]++         # Probiere die erste IP nach der Netz IP
$aktuelleNetzIp=0,0,0,0
while ($imSubnetz) {
    # aktuelle Netz IP bestimmen
    for ($i=0; $i -lt 4;$i++) {
        $aktuelleNetzIp[$i]=$aktuelleIP[$i] -band $sub[$i]
    }

    if ($aktuelleNetzIp[0] -eq $netz[0] -and      # Liegt diese im gleichen Netz?
        $aktuelleNetzIp[1] -eq $netz[1] -and
        $aktuelleNetzIp[2] -eq $netz[2] -and
        $aktuelleNetzIp[3] -eq $netz[3]) {
        Write-Host "IP:"$aktuelleIp[0]"."$aktuelleIp[1]"."$aktuelleIp[2]"."$aktuelleIp[3]
        $aktuelleIP[3]++
        if ($aktuelleIP[3] -gt 255) {
            $aktuelleIP[3]=0;
            $aktuelleIP[2]++;
            if ($aktuelleIP[2] -gt 255) {
                $aktuelleIP[2]=0
                $aktuelleIP[1]++;
                if ($aktuelleIP[1] -gt 255) {
                    $aktuelleIP[1]=0
                    $aktuelleIP[0]++;
                }
            }
        }
    }
    else {
        $imSubnetz=$false
    }
}
