cls
$gebTag = New-Object System.DateTime(1968,4,11)
$today = Get-Date
$gebTag=$gebTag.AddYears($today.Year-$gebTag.Year)
for ($i=0;$i -lt 50;$i++) {
    $gebTag=$gebTag.AddYears(1);
    if ($gebTag.DayOfWeek -eq "Sunday") {
        Write-Host ("Du hast im Jahr "+$gebTag.Year+" wieder auf einen Sonntag Geburtstag")
    }
 
}