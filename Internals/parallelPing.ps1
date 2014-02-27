$datei = Get-Content "$Home\lehrerrechner.txt"
foreach ($zeile in $datei) {
    $ip=($zeile.Split(";"))[0]
    $raum=($zeile.Split(";"))[1]
    $j=Start-Job {
        param ($ip,$raum)
        $result=Test-Connection $ip -Count 1 -Quiet  
        if ($result) {
            "Der Lehrer PC im $raum mit der IP ($ip) ist an"
        }
        else {
            "Der Lehrer PC im $raum mit der IP ($ip) ist aus"
        }
        
    } -ArgumentList $ip,$raum
    Write-Host "Job gestartet "$j.Name   
}

$jobs=Get-Job
while ($jobs) { 
  foreach ($job in $jobs) {
    if ($job.State -ne "running") {
       Write-Host " "$job.Name" beendet:"(Receive-Job $job)
       Remove-Job $job
    }
  }
  $jobs=Get-Job
}
