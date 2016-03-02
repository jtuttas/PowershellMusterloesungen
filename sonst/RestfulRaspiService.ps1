# Abfrage der Temperatur
$temp=Invoke-RestMethod -Method Get -Uri http://service.joerg-tuttas.de:8081/RaspiWeb/api/v1/temperature -Headers @{"content-Type"="application/json"}
Write-Host "Die Temperatur beträgt "$temp.temperature" °C"

#Objekt mit Property "dim" erzeugen.
$dimObject=echo "" | Select-Object -Property "dim"
#Proberty dim setzen
$dimObject.dim=100;
#HTTP-POST auf Webrequest senden
$dim=Invoke-RestMethod -Method Post -Uri http://service.joerg-tuttas.de:8081/RaspiWeb/api/v1/led -Headers @{"content-Type"="application/json"} -Body (ConvertTo-Json $dimObject)
Write-Host "LED dimmer gestezt auf "$dim.dim" %"
sleep 1
$dimObject.dim=30;
$dim=Invoke-RestMethod -Method Post -Uri http://service.joerg-tuttas.de:8081/RaspiWeb/api/v1/led -Headers @{"content-Type"="application/json"} -Body (ConvertTo-Json $dimObject)
Write-Host "LED dimmer gestezt auf "$dim.dim" %"
sleep 1
$dimObject.dim=0;
$dim=Invoke-RestMethod -Method Post -Uri http://service.joerg-tuttas.de:8081/RaspiWeb/api/v1/led -Headers @{"content-Type"="application/json"} -Body (ConvertTo-Json $dimObject)
Write-Host "LED dimmer ausgesetzt"
sleep 1
