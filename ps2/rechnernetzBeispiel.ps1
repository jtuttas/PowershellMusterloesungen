cls
#Datei einlesen in $netz
[xml]$netz=New-Object XML
[xml]$netz=get-Content X:\SchuleSync\Skript\LF6_Anwendungssysteme\Powershell\Fortgeschritten\rechnernetz.xml

#Nur die Elemente selektieren, die PCs sind
#Das geht hier nur über die Endetags, da nur diese 
#in den Nodes identisch sind, die Anfangstags besitzen
#unterschiedliche Attribute
#Der "/" hat in Strings eine besondere Bedeutung:
#Er leitet Steuersequenzen ein und dient zur Angabe
#von ASCII-Zeichen, den "/" selber stellt man durch "//" dar
$pcs = $netz.SelectNodes("//pc")
Write-Host "Ganze PC-Liste"
out-host -inputobject $pcs 
<#
 Diese Elemente stehen nun in $pcs

 <pc mac="23:cd:11:f1:2a:22">
  <ip>192.168.178.2</ip> 
  <name>Franks Desktop</name> 
  </pc>
 <pc mac="23:cd:11:f1:2a:23">
  <ip>192.168.178.3</ip> 
  <name>Franks Notebook</name> 
 </pc>
#>

foreach ($pc in $pcs)
#nun die pc-Elemente nach 'Franks Desktop' durchsuchen
 {
  if ($pc.name -eq "Franks Desktop")
   {
    #Passendes Element löschen
    $netz.childnodes.RemoveChild($pc)
   }
 }

#Geänderte Datei unter anderem Namen speichern
$netz.Save("X:\SchuleSync\Skript\LF6_Anwendungssysteme\Powershell\Fortgeschritten\rechnernetzChanged.xml")
