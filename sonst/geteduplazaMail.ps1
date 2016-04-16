$o =""| Select-Object -Property name,vorName,gebDatum
$o.name="Voges"
$o.vorName="Sebastian"
$o.gebDatum="1983-02-28"
$r=Invoke-RestMethod -Method Post -Uri http://localhost:8080/Diklabu/api/v1/kurswahl/login -Body (ConvertTo-Json $o) -Headers @{"content-Type"="application/json"}
Write-Host $r.eduplazaMail
