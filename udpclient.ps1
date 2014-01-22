$port=2021
$endpoint = new-object System.Net.IPEndPoint ([IPAddress]"10.13.6.100",$port)
$udpclient=new-Object System.Net.Sockets.UdpClient
$b=[Text.Encoding]::ASCII.GetBytes('Is anyone there!')
$bytesSent=$udpclient.Send($b,$b.length,$endpoint)
$udpclient.Close()
