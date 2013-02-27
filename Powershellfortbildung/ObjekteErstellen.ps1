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

