cls
# Primzahlen bestimmung mit der Powershell
$geb = Read-Host ("Der wievielte Primzahlengeburtstag?")
$jahre=2;
$pzahl=2
$i=1;
while ($i -le $geb) {
	$pzahl=$jahre
	for ($j=2;$j -lt $jahre;$j=$j+1) {
		
		if ($pzahl%$j -eq 0) {
			$j=2000
		}
	}
	$jahre++
	if ($j -ne 2001) {
		#Write-Host ("Die Zahl $pzahl ist eine Primzahl")
		$i++
	}
}
$jahre--
Write-Host ("Sie sind $jahre alt")
