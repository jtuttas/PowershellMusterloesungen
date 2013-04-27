cls
$d = Get-Content .\Geburtstage.csv
$filename = "geburtstage.ics"
"" | Set-Content $filename
$idcount=1;
"BEGIN:VCALENDAR" | Add-Content $filename
"PRODID:-//Google Inc//Google Calendar 70.9054//EN" | Add-Content $filename
"VERSION:2.0"| Add-Content $filename
"CALSCALE:GREGORIAN"| Add-Content $filename
"METHOD:PUBLISH"| Add-Content $filename
foreach ($zeile in $d) {
    $daten = $zeile.Split(";")
    "BEGIN:VEVENT"| Add-Content $filename
    "RRULE:FREQ=YEARLY"| Add-Content $filename
    "UID:4610923155122"+$idcount+"@mmbbs.de" | Add-Content $filename
    "LOCATION:MMBBS"| Add-Content $filename
    "SEQUENCE:0"| Add-Content $filename
    "STATUS:CONFIRMED"| Add-Content $filename
    "TRANSP:TRANSPARENT"| Add-Content $filename
    $organizer = "ORGANIZER;CN="+$daten[3]+" "+$daten[2]+":MAILTO:"+$daten[2]+"@mmbbs.de"
    $organizer | Add-Content $filename
    "LOCATION:MMBBS"| Add-Content $filename
    "SUMMARY:Geburtstag "+$daten[3]+" "+$daten[2] | Add-Content $filename
    "DESCRIPTION: Heute hat "+$daten[3]+" "+$daten[2]+" Geburtstag" | Add-Content $filename
    "CLASS:PUBLIC"| Add-Content $filename
    if ($daten[0].Length -lt 2) {
        $daten[0] = "0"+$daten[0];
    }
    if ($daten[1].Length -lt 2) {
        $daten[1] = "0"+$daten[1];
    }
    "DTSTART;VALUE=DATE:2013"+$daten[1]+$daten[0] | Add-Content $filename
    "DTEND;VALUE=DATE:2013"+$daten[1]+$daten[0] | Add-Content $filename
    "RRULE:FREQ=YEARLY"| Add-Content $filename
    "END:VEVENT"| Add-Content $filename
    $idcount++
    Write-Host ("Einttrag für "+$daten[3]+" "+$daten[2]+" erzeugt")
}
"END:VCALENDAR" | Add-Content $filename
