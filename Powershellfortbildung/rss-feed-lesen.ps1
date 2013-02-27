$webClient = new-object System.Net.WebClient
$proxy = new-object System.Net.WebProxy "10.20.30.55:3128" 
$cred = New-Object System.Net.NetworkCredential 'veranstaltung', 'qwertz'

$proxy.Credentials = $cred #(Get-Credential).GetNetworkCredential()
#$proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
$webclient.proxy=$proxy 
$webClient.Headers.Add("user-agent", "Windows Powershell WebClient Header")
$webClient.UseDefaultCredentials = $true
$url = 'http://weather.yahooapis.com/forecastrss?w=12833399&u=c'


[XML]$alles = $webClient.DownloadString($url)
$alles.rss.channel.wind.speed

