cls
# Ergänzen einer XML-Datei
# Sie enthält URLs und eine Beschreibung dazu
# "Vorher"

# Einlesen von Datei...
# $doc = [xml] (Get-Content -Path websites.xml)
# oder mal anders, nämlich hartcodiert, also im Quelltext des PS-Scripts:

$doc = new-object XML
[XML]$doc = '<?xml version="1.0" encoding="utf-8"?>
<Websites>
  <Website ID="1">
    <URL>www.ix.de</URL>
    <Beschreibung>Website des iX-Magazins</Beschreibung>
  </Website>
  <Website ID="2">
    <URL>www.IT-Visions.de</URL>
    <Beschreibung>Websites des Autors dieses Beitrags</Beschreibung>
  </Website>
  <Website ID="3">
    <URL>www.dotnetframework.de</URL>
    <Beschreibung>Community-Site für .NET-Entwickler</Beschreibung>
  </Website>
  <Website ID="4">
    <URL>www.Windows-Scripting.de</URL>
    <Beschreibung>Community-Site für WSH- und PowerShell-Entwickler</Beschreibung>
  </Website>
  <Website ID="5">
    <URL>www.powershell-doktor.de</URL>
    <Beschreibung>Community-Site zur Microsoft PowerShell</Beschreibung>
  </Website>
</Websites>'

$doc.Save("websites_old.xml") 
# $doc.Websites.Website | select URL,Beschreibung

# "Nachher"
$site = $doc.CreateElement("Website")
#<Website></Website> -->$site
#
$site.SetAttribute("ID","6")
#<Website ID="6"></Website> --> $site
#
$url =  $doc.CreateElement("URL")
#<URL></URL> --> $url
#
$url.set_Innertext("moodle2.mmbbs.de")
#<URL>moodle2.mmbbs.de</URL> --> $url
#
$beschreibung =  $doc.CreateElement("Beschreibung")
#<Beschreibung></Beschreibung> --> $beschreibung
#
$beschreibung.set_Innertext("Multi Media BbS Moodle")
#<Beschreibung>Multi Media BbS Moodle</Beschreibung> --> $beschreibung
#
$site.AppendChild($url)
<#
<Website ID="6">
  <URL>moodle2.mmbbs.de</URL>
</Website> -->$site
#>
$site.AppendChild($Beschreibung)
<#
<Website ID="6">
  <URL>moodle2.mmbbs.de</URL>
  <Beschreibung>Multi Media BbS Moodle</Beschreibung>
</Website> -->$site
#>
$doc.Websites.AppendChild($site)
<#
<?xml version="1.0" encoding="utf-8"?>
<Websites>
  <Website ID="1">
    <URL>www.ix.de</URL>
    <Beschreibung>Website des iX-Magazins</Beschreibung>
  </Website>
.
.
.
  <Website ID="5">
    <URL>www.powershell-doktor.de</URL>
    <Beschreibung>Community-Site zur Microsoft PowerShell</Beschreibung>
  </Website>
  
  !!!!!Hier kommt nun unser hinzugefügtes Element hinein
  <Website ID="6">
    <URL>moodle2.mmbbs.de</URL
    <Beschreibung>Multi Media BbS Moodle</Beschreibung>
  </Website>
</Websites>

#>
out-host -inputobject ($doc.Websites.Website | select URL,Beschreibung)
# "Dokument speichern"
$doc.Save("websites_new.xml")
cls
#"Filtern der Ausgabe"
#"1. Spalten filtern: Nur URL ausgeben
$s=$doc.Websites.Website | Select-Object URL
out-host -inputobject $s
#2. Zeilen filtern: nur Datensatz mit ID 3 ausgeben
$z=$doc.Websites.Website | where-object {$_.ID -eq 3}
out-host -inputobject $z
write-host "Fertig"
