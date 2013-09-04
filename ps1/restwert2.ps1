cls
$z = Read-Host ("Zahl eingeben")
$s=""
for ($i=7;$i -ge 0;$i--) {
    if ($z -ge [math]::pow(2,$i)) {
        $s+="1"
        $z=$z-[math]::pow(2,$i)
    }
    else {
        $s+="0"
    }
    
}

Write-Host (" Dual=$s")
