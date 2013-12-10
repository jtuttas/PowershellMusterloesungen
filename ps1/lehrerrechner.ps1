cls
# Eingeschaltete Lehrerrechnik im 3. Stock
$ip1="10.13."
for ($n=1;$n -lt 20;$n=$n+1) {
	$ip=$ip1+$n+".100";
	$test = Test-Connection $ip -Count 1 -Quiet
	$raum=$n+300;
	if ($test) {
		Write-Host ("Lehrer Rechner im Raum $raum ist an!") -ForegroundColor Green
	}
	else {
		Write-Host ("Lehrer Rechner im Raum $raum ist aus!") -ForegroundColor Red
	}
}
