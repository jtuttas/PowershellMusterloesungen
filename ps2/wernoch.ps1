cls
$tag=Read-Host "Tag"
$monat=Read-Host "Monat (z.B. April)"
$jahr=Read-Host "Jahr (z.B. 1968)"
$webClient = new-object System.Net.WebClient
#$proxy = new-object System.Net.WebProxy "10.20.30.55:3128" 
#$cred = New-Object System.Net.NetworkCredential 'veranstaltung', 'qwertz'

#$proxy.Credentials = $cred #(Get-Credential).GetNetworkCredential()
#$proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
#$webclient.proxy=$proxy 
$webClient.Headers.Add("user-agent", "Windows Powershell WebClient Header")
#$webClient.UseDefaultCredentials = $true
$url = 'http://api.wolframalpha.com/v2/query?appid=QLVUAK-TVH4R83V4U&input=notable%20people%20born%20on%20'+$monat+'%20'+$tag+'%20'+$jahr+'&format=plaintext'
[XML]$alles = $webClient.DownloadString($url)

## oder so
#[xml]$b = Invoke-WebRequest "http://api.wolframalpha.com/v2/query?appid=QLVUAK-TVH4R83V4U&input=notable%20people%20born%20on%20April%2011%201968&format=plaintext"
$name=$alles.queryresult.pod[1].subpod.InnerText
Write-Host ("Am "+$tag+"."+$monat+"."+$jahr+" wurde auch "+$name+" gebohren")
