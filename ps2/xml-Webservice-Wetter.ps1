$webClient = new-object System.Net.WebClient
$mmbbs = Read-Host ("Sind sie in der Schule hinter dem Proxy? j/n")
if ($mmbbs -eq "j") {
    $proxy = new-object System.Net.WebProxy "10.20.30.55:3128" 
    $login = Read-Host ("Benutzername")
    $pw = Read-Host ("Kennwort")
    $cred = New-Object System.Net.NetworkCredential $login, $pw

    $proxy.Credentials = $cred #(Get-Credential).GetNetworkCredential()
    #$proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    $webclient.proxy=$proxy 
}
$webClient.Headers.Add("user-agent", "Windows Powershell WebClient Header")
$webClient.UseDefaultCredentials = $true
$url = 'http://weather.yahooapis.com/forecastrss?w=12833399&u=c'
[XML]$alles = $webClient.DownloadString($url)
$node= $alles.rss.channel.GetElementsByTagName("yweather:wind")
Write-Host ("An der MMBBS sind es gerade "+$a[0].GetAttribute("chill")+" °C")