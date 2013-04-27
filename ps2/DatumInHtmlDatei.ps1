cls
$d=Get-Content ("datum.html")
$i=1
$t=Get-Date
foreach ($line in $d) {
	if ($line -match "<h1>Heute ist der:") {
		$line="<h1>Heute ist der: $t</h1>"
	}
	if ($i-eq 1) {
		$line | Set-Content("datum.html")
	}
	else {
		$line | Add-Content("datum.html")
	}
	Write-Host ("$i $line")
	$i++
}




