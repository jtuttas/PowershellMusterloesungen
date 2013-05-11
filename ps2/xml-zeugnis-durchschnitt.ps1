cls
[xml]$a = Get-Content  ("schulklasse_zeugnis.xml")
$n = $a.SelectNodes("//pupil")
foreach ($p in $n) {
    $sum=0
    $z=$p.zeugnis.FirstChild
    
    do {
        if ($z.Name -ne "fehlzeiten") {
            $sum=$sum+$z.InnerText
        }
        
    }
    while ($z=$z.NextSibling)
    $p.zeugnis.SetAttribute("average",$sum/4)

}
$a.Save("schulklasse_zeugnis_neu.xml")
