
cls
[xml]$a = Get-Content  ("D:\Dropbox\temp\rechnernetz.xml")
$n = $a.SelectNodes("//pc")
foreach ($p in $n) {
    if ($p.name -eq "Franks Notebook") {
        $p.ip="192.168.178.10"
    }
}
$a.Save("D:\Dropbox\Temp\rechnernetz_neu.xml")
