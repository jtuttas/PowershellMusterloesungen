Param(
	[String]$file
)
function check ([String]$ipadress) {
	#param ($ipadress)
	$ipadress -match "(\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b)" 
}

if ($file -ne "") {
	$dir = Get-Location
	
	$file="$dir\$file"
	if (Test-Path $file) {
	
		[xml] $xml = gc $file
		cls;
		$lastMessung = $xml.messung.zeit;
		if ($lastMessung -eq 0) {
			$lastDate=Get-Date
			$lastMessung = $lastDate.ToUniversalTime().Ticks
			$xml.messung.zeit=[String]$lastMessung
			Write-Host "Initialisierung des Programms (keine Arbeitsmessung möglich)" -foregroundcolor black -backgroundcolor red
			$xml.save($file)
			exit		
		}
		$actualDate =Get-Date
		$lastDate = New-Object System.DateTime $lastMessung
		$lastDate = $lastDate.AddHours(2);
		echo "Aktuelle Messung $actualDate letzte Messung $lastDate"
		$msa=$actualDate.ToUniversalTime().Ticks
		$ms=$lastDate.ToUniversalTime().Ticks
		$div=$actualDate-$lastDate
		echo "Zeitspanne seit der letzten Messung $div"
		$xml.messung.zeit=[String]$msa

		$ping = new-object system.net.networkinformation.ping
		[double]$arbeit=0;
		foreach($node in $xml.GetElementsByTagName("rechner"))
		{
		 	$ip=$node.ip;
			#$result= check "127.0.0.1";
			$result= check $ip
			if ($result) {
				echo "ping auf $ip";
				$pingreturns = $ping.send($ip).Status
				if ($pingreturns -match "Success") {
					[float]$w=$node.arbeit;
					[float]$p=$node.leistung;
					$p=$p*$div.get_Milliseconds()/(1000*60*60);
					$w+=$p;
					$arbeit+=$w;
					$node.arbeit=[String]$w
					Write-Host "  Der Rechner ist an! addiere $p Wh" -foregroundcolor black -backgroundcolor green
				}
				else {
					Write-Host "  Der Rechner $ip ist aus" -foregroundcolor black -backgroundcolor red
				}
			}
			else {
				Write-Host (" $ip ist keine gültige IP-Adresse") -foregroundcolor black -backgroundcolor red
			}			
		}
		Write-Host ("Gesamte Verbrauchte Arbeit sind $arbeit Wh");
		$xml.save($file)
	}
	else {
		Write-Host "Konnte das File $file nicht finden!" -foregroundcolor red
	}
}
else {
	Write-Host "usage ./energieverbrauch.ps1 config.xml"
}


