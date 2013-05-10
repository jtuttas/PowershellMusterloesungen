
cls
[xml]$a = Get-Content  ("D:\Dropbox\temp\schulklasse.xml")
$s=$a.CreateElement("pupil")
$s.SetAttribute("name","Thomas")
$s.SetAttribute("age","21")
$s.SetAttribute("gender","male")
$a.klasse.AppendChild($s)
$a.Save("D:\Dropbox\temp\schulklasse_neu.xml")
