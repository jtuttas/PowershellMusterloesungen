cls
$out = "[Thema]
Thema=1AJ`r`n" 
$csv_file = Read-Host "CSV Datei [Tabelle.csv]"
if ($csv_file -eq "") {
    $csv_file="./Tabelle.csv"
}

$csv = Get-Content $csv_file -Encoding UTF8 
$questnum=1
$out2=""
foreach ($zeile in $csv) {
    $za = $zeile.Split(",")
    $out2= $out2+"["+$questnum+"]`r`n"
    $out2 = $out2+"FZ1=`r`n"
    $out2 = $out2+"FZ2="+$za[1]+"`r`n"
    $out2 = $out2+"FZ3=`r`n"
    $out2 = $out2+"Min="+$za[6]+"`r`n"
    $out2 = $out2+"Max="+$za[7]+"`r`n"
    $out2 = $out2+"Antwort_1="
    $za[2]=$za[2].TrimStart("`"")
    $za[2]=$za[2].TrimEnd("`"")
    
    if ($za[8] -eq 1) {
        $out2 = $out2+"1"+$za[2]
    }
    else {
        $out2 = $out2+"0"+$za[2]
    }
    $out2 = $out2+"`r`nAntwort_2="
    $za[3]=$za[3].TrimStart("`"")
    $za[3]=$za[3].TrimEnd("`"")
    if ($za[8] -eq 2) {
        $out2 = $out2+"1"+$za[3]
    }
    else {
        $out2 = $out2+"0"+$za[3]
    }
    $out2 = $out2+"`r`nAntwort_3="
    $za[4]=$za[4].TrimStart("`"")
    $za[4]=$za[4].TrimEnd("`"")

    if ($za[8] -eq 3) {
        $out2 = $out2+"1"+$za[4]
    }
    else {
        $out2 = $out2+"0"+$za[4]
    }
    $out2 = $out2+"`r`nAntwort_4="
    $za[5]=$za[5].TrimStart("`"")
    $za[5]=$za[5].TrimEnd("`"")

    if ($za[8] -eq 4) {
        $out2 = $out2+"1"+$za[5]
    }
    else {
        $out2 = $out2+"0"+$za[5]
    }
    $out2=$out2+"`r`n`r`n"
    $questnum++
    
}
$questnum--
$out = $out+ "Fragen="+$questnum+"`r`n"
$out = $out +"Autor=Powershell`r`n"
$out_file = Read-Host "Ausgabedatei [fragen.txt]"
if ($out_file -eq "") {
    $out_file="fragen.txt"
}
$out | Set-Content $out_file -Encoding String
$out2 | Add-Content $out_file -Encoding String
