$port=2027
$clients = @{}
$endpoint = new-object System.Net.IPEndPoint ([IPAddress]::Any,$port)
$udpclient=new-Object System.Net.Sockets.UdpClient $port
$udpclient.Client.ReceiveTimeout=10000
Write-Host "Der Server läuft au Port $port" 
do {
    try {
        $content=$udpclient.Receive([ref]$endpoint)
        if ($clients.ContainsKey([String]$endpoint.Address)) {
            Write-Host "Empfange von Client:"$endpoint.Address
        }
        else {    
            Write-Host "Neue Verbindung von Client"$endpoint.Address
            [String]$url=$endpoint.Address
            $clients.Add($url,[System.Net.IPEndPoint]$endpoint)
        }
   
        $b=[Text.Encoding]::ASCII.GetString($content)
        Write-Host "Empfange [$b]"

        foreach ($client in $clients) {
            [String]$k=$clients.Keys[0]
            $e=$clients[$k]
            $txt = $endpoint.Address.ToString()+"-> "+$b
            $b=[Text.Encoding]::ASCII.GetBytes($txt)
            try {
                $bytesSent=$udpclient.Send($b,$b.length,[System.Net.IPEndPoint]$e)
                Write-Host "sende [$txt] an "$e.Address
            }
            catch {
              [String]$url=$e.Address
              $clients.Remove($url)
              Write-Host "-Entferne Client "$e.Address
            }
        }

    }
    catch {
      [String]$url=$endpoint.Address
      $clients.Remove($url)
      Write-Host "Entferne Client "$url
    }
}
while ($true)

$udpclient.Close()
