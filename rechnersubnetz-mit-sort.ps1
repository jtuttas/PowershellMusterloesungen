cls
$x=Get-Content("d:/Temp/ips.txt")
$netzip = new-object String[] $x.Length
$j=0
foreach ($txtip in $x) {
 $ips=$txtip.Split(";")
 #Write-Host ("IP ist "+$ips[0]+" Subnetzmaske ist "+$ips[1])
 
 $oip=$ips[0].Split(".")
 $osubnetz=$ips[1].Split(".")
 $netz=0,0,0,0
 for ($i=0;$i -lt 4;$i++) {
 	$netz[$i]=$oip[$i] -band $osubnetz[$i]
 }
 $netzip[$j]=""+$netz[0]+"."+$netz[1]+"."+$netz[2]+"."+$netz[3] 
 $j++
}
$netzip = $netzip | sort
$anzahl=1
for ($j=0;$j -lt $netzip.Length-1;$j++) {
	
	if ($netzip[$j] -eq $netzip[$j+1]) {
		$anzahl++;
	}
	else {
		Write-Host ("Das Netz mit der Netzip "+$netzip[$j]+" hat "+$anzahl+" Rechner")
		$anzahl=1;
	}
	
}
Write-Host ("Das Netz mit der Netzip "+$netzip[$j]+" hat "+$anzahl+" Rechner")