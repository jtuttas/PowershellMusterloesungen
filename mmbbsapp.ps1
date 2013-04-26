cls
$urlStdPLan="stundenplan.mmbbs.de/plan1011/klassen/frames/navbar.htm"
$urlVertrPlan="stundenplan.mmbbs.de/plan1011/ver_kla/frames/navbar.htm"
$stdplan = @{}
$vplan = @{}
Write-Host ("Lese Stundenplan")
$html = Invoke-WebRequest $urlStdPlan
$html = $html.Content
$html = $html.Split("`r`n");
$resultArray = @();
foreach ($zeile in $html) {
    if ($zeile -match "var classes") {
        Write-Host ("+-- Var Classes gefunden!")
        $zeile=$zeile.Substring($zeile.IndexOf("["))
        $zeile=$zeile.TrimStart("[");
        $zeile=$zeile.TrimEnd("];")
        $zeile=$zeile.Split(",")
        $i=1

        foreach ($klasse in $zeile) {
            
            $klasse = $klasse.Substring(1,$klasse.length-2)
            #$klasse
            $stdplan.Add($klasse,$i)
            #$objekt.Klasse=$klasse
            #$objekt.IDPlan=$i
            $i++
            #$resultArray += $objekt
        }   
    }
}
Write-Host ("Lese Vertretungsplan")
$html = Invoke-WebRequest $urlVertrPlan
$html = $html.Content
$html = $html.Split("`r`n");
$resultArray = @()
foreach ($zeile in $html) {
    if ($zeile -match "var classes") {
        Write-Host ("+-- Var Classes gefunden!")
        $zeile=$zeile.Substring($zeile.IndexOf("["))
        $zeile=$zeile.TrimStart("[");
        $zeile=$zeile.TrimEnd("];")
        $zeile=$zeile.Split(",")
        $i=1

        foreach ($klasse in $zeile) {               
            $klasse = $klasse.Substring(1,$klasse.length-2)                
            $vplan.Add($klasse,$i)
            $i++
        }   
    }
}

Write-Host ("Erzeuge Result Objekt")
foreach($key in $stdplan.keys){
    $objekt = 'dummy' | Select-Object -Property Klasse, IDPlan, IDVPlan
    $objekt.Klasse=$key
    $objekt.IDPlan=$stdPlan[$key]
    $objekt.IDVPlan=$vplan[$key]
    $resultArray+=$objekt
    
}

$resultArray=$resultArray | sort { $_.Klasse}
$resultArray
