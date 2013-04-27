cls
function dreh([String]$a) {
    $out=""
    for ($i=$a.Length-1;$i -ge 0;$i--) {
        $out=$out+$a.Chars($i)
    }
    return $out
}
 
$a=dreh ("Hallo")
Write-Host ("Gedreht ("+$a+")")