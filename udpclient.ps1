$port=2024
$endpoint = new-object System.Net.IPEndPoint ([IPAddress]"127.0.0.1",$port)
$udpclient=new-Object System.Net.Sockets.UdpClient
$b=[Text.Encoding]::ASCII.GetBytes('Is anyone there!')
$bytesSent=$udpclient.Send($b,$b.length,$endpoint)
$udpclient.Close()
