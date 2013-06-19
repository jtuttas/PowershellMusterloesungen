function StartConvert ($inFile, $outFile) {
    $csv = Import-Csv $inFile
    $out = "[Thema]
Autor=Powershell`r`nThema=1AJ`r`nFragen="+($csv.length)+"`r`n`r`n"
    for ($i=0;$i -lt $csv.length;$i++) {

        $out= $out+"["+($i+1)+"]`r`n"
        $out = $out+"FZ1=`r`n"
        $out = $out+"FZ2="+$csv[$i].'Die Frage'+"`r`n"
        $out = $out+"FZ3=`r`n"
        $out = $out+"Min="+$csv[$i].'Min'+"`r`n"
        $out = $out+"Max="+$csv[$i].'Max'+"`r`n"

        $out = $out+"Antwort_1="
        if ($csv[$i].'Welche Antwort ist richtig?' -eq 1) {
            $out = $out+"1"+$csv[$i].'Antwort 1'
        }
        else {
            $out = $out+"0"+$csv[$i].'Antwort 1'
        }
        $out = $out+"`r`n"
    
        $out = $out+"Antwort_2="
        if ($csv[$i].'Welche Antwort ist richtig?' -eq 2) {
            $out = $out+"1"+$csv[$i].'Antwort 2'
        }
        else {
            $out = $out+"0"+$csv[$i].'Antwort 2'
        }
        $out = $out+"`r`n"
    
        $out = $out+"Antwort_3="
        if ($csv[$i].'Welche Antwort ist richtig?' -eq 3) {
            $out = $out+"1"+$csv[$i].'Antwort 3'
        }
        else {
            $out = $out+"0"+$csv[$i].'Antwort 3'
        }
        $out = $out+"`r`n"
    
        $out = $out+"Antwort_4="
        if ($csv[$i].'Welche Antwort ist richtig?' -eq 4) {
            $out = $out+"1"+$csv[$i].'Antwort 4'
        }
        else {
            $out = $out+"0"+$csv[$i].'Antwort 4'
        }
        $out = $out+"`r`n`r`n"
    
    }



    $out | Set-Content $outFile -Encoding String
}

#StartConvert Tabelle.csv test.txt

