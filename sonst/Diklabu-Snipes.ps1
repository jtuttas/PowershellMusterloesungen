<#
Coole Code Snipes (einfach markieren und F8 drücken!)
#>

#Liste der Ausbilder der FISI14A
Find-Coursemember -KNAME FISI14A | Get-Pupil | ForEach-Object {$_.ausbilder}| Out-GridView

#Welche Auszubildenden in den FIAE Klassen sind bei Rossmann beschäftigt
$rossmann = Find-Company -NAME "%Rossmann%"
foreach ($r in $rossmann) {
    Find-Coursemember -KNAME "FIAE%" | Get-Pupil | ForEach-Object {if ($_.betrieb.ID -eq $r.ID) {$_}} 
}

#Legt die Schüler der WPK's von TU zusammen in eine neue Klasse WPK_TU_Meta
$c=New-Course -KNAME "WPK_TU_Meta" -TITEL "Mein Meta Kurs" -ID_LEHRER "TU"
Find-Coursemember -KNAME "IT15_WPK_TU%" | Add-Coursemember -klassenid $c.id

#Alle Schüler wieder aus dem Kurs WPK_TU_Meta entfernen
$c=Find-Course -KNAME "WPK_TU_Meta"
Find-Coursemember -KNAME "WPK_TU_Meta" | Remove-Coursemember -klassenid $c.id

# Commandlets anzeigen
Get-Command -Module diklabu |  Get-Help | Select-Object -Property Name,Synopsis

# EMail Adressen der Schüler der Klasse FISI14A  als QR Code
"FISI14A"|find-coursemember|Get-Pupil | Select-Object -Property email,name | ForEach-Object {$n="$HOME\Desktop\"+$_.name+".jpg";$s="https://chart.googleapis.com/chart?cht=qr&chl=mailto:"+$_.email+"&chs=300x300";Start-BitsTransfer -Source $s -Destination $n}

