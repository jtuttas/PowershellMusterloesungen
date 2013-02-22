cls
$z = Read-Host ("Zahl eingeben")
$s=""
do {
	$rest=$z % 2
	$teiler = ($z - $rest)/2
	Write-Host ("$z : 2 = $teiler Rest $rest")
	$s=$s+$rest
	$z=$teiler
}
while ($teiler -gt 0)
Write-Host ("Dual=$s")