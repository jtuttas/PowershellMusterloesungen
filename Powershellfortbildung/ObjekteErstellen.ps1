$code = {
   ([DateTime]($this.Geburtsdatum)).DayOfWeek
}

$code2 = {
    param($Tage)

    "Habe empfangen: $Tage"

}



$objekt = 'dummy' | Select-Object -Property Vorname, Nachname, Geburtsdatum

$objekt | Add-Member -MemberType ScriptMethod -Name 'GetBirthday' -Value $Code
$objekt | Add-Member -MemberType ScriptMethod -Name 'GetAge' -Value $Code2

$o=New-Object PsObject
$o | Add-Member -MemberType NoteProperty -Value "MMBBS" -Name "Schule"
$o | Add-Member -MemberType NoteProperty -Value "Straﬂe" -Name "ExpoPlaza"
$o | Add-Member -MemberType ScriptMethod -Name 'GetAge' -Value $Code2



$c1= {
    
    [int]$script:age=10;
    $script:bother=$null

    function getOlder() {
        $script:age++
    }

    function getYounger() {
        $script:age--
    }

    function toString() {
        "Ich bin $age jahre alt"
        if ($bother -ne $null) {
            "Ich habe einen Bruder und der ist "+$bother.getAge()+" Jahre alt"
        }
    }

    function getAge() {
        $age
    }

    function setBother($b) {
        $script:bother=$b
    }
    Export-ModuleMember -Variable * -Function * 
}

$me = New-Module -AsCustomObject -ScriptBlock $c1
$you = New-Module -AsCustomObject -ScriptBlock $c1

