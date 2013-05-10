cls
[xml]$a = Get-Content  ("D:\Dropbox\temp\rechnernetz.xml")
$pc=$a.CreateElement("pc")
$pc.SetAttribute("mac","12:33:ef:ff:a2:7a")
$ip=$a.CreateElement("ip")
$ip.innerText="192.168.178.7"
$pc.AppendChild($ip)
$name=$a.CreateElement("name")
$name.innerText="Franks Tablet"
$pc.AppendChild($name)
$a.rechnernetz.AppendChild($pc)
$a.Save("D:\Dropbox\temp\rechnernetz_neu.xml")
