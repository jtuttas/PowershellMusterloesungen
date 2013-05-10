
cls
[xml]$a = Get-Content  ("D:\Dropbox\temp\rechnernetz.xml")
$n = $a.SelectNodes("//pc")
foreach ($p in $n) {
    if ($p.name -eq "Franks Notebook") {
        $a.rechnernetz.RemoveChild($p)
    }
}
$a.Save("D:\Dropbox\Temp\rechnernetz_neu.xml")
