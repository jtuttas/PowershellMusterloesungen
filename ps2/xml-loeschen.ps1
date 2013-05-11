
cls
[xml]$a = Get-Content  ("D:\Dropbox\temp\schulklasse.xml")
$n = $a.SelectNodes("//pupil")
foreach ($p in $n) {
    if ($p.GetAttribute("name") -eq "Nina") {
        $a.klasse.RemoveChild($p)
    }
}
$a.Save("D:\Dropbox\Temp\schulklasse_neu.xml")
