cls
$x=Get-Content("f:/Temp/ips.txt")
$rechner = New-Object hashtable
foreach ($txtip in $x) {
 $ips=$txtip.Split(";")
 #Write-Host ("IP ist "+$ips[0]+" Subnetzmaske ist "+$ips[1])
 
 $oip=$ips[0].Split(".")
 $osubnetz=$ips[1].Split(".")
 $netz=0,0,0,0
 for ($i=0;$i -lt 4;$i++) {
 	$netz[$i]=$oip[$i] -band $osubnetz[$i]
 }
 $netzip=""+$netz[0]+"."+$netz[1]+"."+$netz[2]+"."+$netz[3] 
 if ($rechner.Contains($netzip)) {
 	$rechner[$netzip]++
 }
 else {
    $rechner.Add($netzip,1)
 }
}
$rechner
