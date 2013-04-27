function ipclass ([string]$ip) {
    [array]$x = $ip.Split(".")
    if($x[0] -le 127)
    {
        return "A";
    }
    if($x[0] -gt 127 -and $x[0] -le 191)
    {
        return "B";
    }
    if($x[0] -gt 191 -and $x[0] -le 223)
    {
        Return "C"
    }
}
 
cls
$ip = Read-Host ("Geben Sie eine IP Adresse an")
$result=ipclass($ip)
if ($result -eq "A") {
    Write-Host ("Sie sind in einem großen Netz!")
}