param (
    [int]$dt,
    [int]$count
)

function cpu-load {
    $p = Get-WmiObject win32_processor
    $load = 'load' | Select-Object -Property Timestamp, Load
    $load.Timestamp = Get-Date
    $load.Load = $p.LoadPercentage
    $load
}

for ($i=0;$i -lt $count;$i++) {
    cpu-load
    sleep $dt
}