Write-Host "Zählen startet"
$z1 = Start-Job {
   for ($i=0;$i -lt 3;$i++) {
        "Zaehler 1 ist bei $i" 
        sleep 1
    }
}
$z2 = Start-Job {
   for ($i=0;$i -lt 6;$i++) {
        "Zaehler 2 ist bei $i" 
        sleep 1
    }
}

while ($z2.State -eq "Running" -or $z1.State -eq "Running") {

    if ($z1.HasMoreData -and $z1.State -eq "Running") { Receive-Job -Job $z1}
    if ($z2.HasMoreData -and $z2.State -eq "Running") { Receive-Job -Job $z2}
}
Write-Host "Zählen beendet" 
